import { watch, writeFileSync, readdirSync, unlinkSync } from 'node:fs';
import path from 'node:path';
import { createHash } from 'node:crypto';
import browserslist from 'browserslist';
import { bundle, browserslistToTargets } from 'lightningcss';

const SOURCE_DIR = './styles';
const ROOT_FILE_PATH = `${SOURCE_DIR}/main.css`;
const OUTPUT_DIR = './assets/css';

const targets = browserslistToTargets(browserslist('>= 0.25%'))

function renderCss(filePath) {
    return bundle({
        filename: filePath,
        minify: true,
        targets,
    });
}

function getContentHash(s) {
    return createHash('md5').update(s).digest("hex")
}

function removeAllFilesSync(dir, match) {
    const files = readdirSync(dir);
    for (const file of files) {
        if (!match(file)) continue;
        const filePath = path.join(dir, file);
        unlinkSync(filePath);
    }
}

function isStyleFile(fileName) {
    if (!fileName) return;
    const isTemporary = fileName.endsWith('~');
    const isStyle = fileName.endsWith('.less') || fileName.endsWith('.css');
    return !isTemporary && isStyle;
}

function rebuildStyles(rootFilePath, outputDir) {
    const { code } = renderCss(rootFilePath);
    const extToDelete = '.min.css';
    console.log(`Removing previously generated files (*${extToDelete}) in ${outputDir}`);
    removeAllFilesSync(outputDir, name => name.endsWith(extToDelete));
    const fileBaseName = rootFilePath.split('/').pop().split('.').shift();
    const hash = getContentHash(code).substring(0, 8);
    const newFilePath = `${outputDir}/${fileBaseName}-${hash}.min.css`;
    console.log('Writing to ', newFilePath);
    writeFileSync(newFilePath, code);
}

function watchLessDirectory(path, callback) {
    watch(path, (eventType, fileName) => {
        if (!isStyleFile(fileName)) return;

        if (eventType === 'change') {
            console.log('Rebuilding styles...');
            callback();
        } else {
            console.log(`Ignored event type ${eventType} on file ${fileName}`);
        }
    });
}

function rebuildCallback() {
    rebuildStyles(ROOT_FILE_PATH, OUTPUT_DIR);
}

// Rebuild when starting, just in case this script wasn't running when files were edited
rebuildCallback();
watchLessDirectory(SOURCE_DIR, rebuildCallback);
