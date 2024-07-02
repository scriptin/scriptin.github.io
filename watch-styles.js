import { watch, readFileSync, writeFileSync, readdirSync, unlinkSync } from 'node:fs';
import path from 'node:path';
import { createHash } from 'node:crypto';
import less from 'less';
import PluginCleanCSS from 'less-plugin-clean-css';

const SOURCE_PATH = './less';
const ROOT_FILE_PATH = `${SOURCE_PATH}/style.less`;
const OUTPUT_DIR = './assets/css';

function replaceRelativeImports(fileContents, filePath) {
    const pathPrefixParts = filePath.split('/')
    pathPrefixParts.pop();
    const pathPrefix = pathPrefixParts.join('/');
    return fileContents
        .replaceAll(/@import \(inline\) "(.*)";/g, `@import (inline) "./${pathPrefix}/$1";`)
        .replaceAll(/@import "(.*)";/g, `@import "./${pathPrefix}/$1";`);
}

async function renderCss(filePath) {
    const fileContents = readFileSync(filePath, { encoding: 'utf8' });
    const css = replaceRelativeImports(fileContents, filePath);
    const cleanCSSPlugin = new PluginCleanCSS({ advanced: true });
    return less.render(css, { env: 'production', plugins: [cleanCSSPlugin] });
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
    renderCss(rootFilePath).then(({ css }) => {
        const extToDelete = '.min.css';
        console.log(`Removing previously generated files (*${extToDelete}) in ${outputDir}`);
        removeAllFilesSync(outputDir, name => name.endsWith(extToDelete));
        const fileBaseName = rootFilePath.split('/').pop().split('.').shift();
        const hash = getContentHash(css).substring(0, 8);
        const newFilePath = `${outputDir}/${fileBaseName}-${hash}.min.css`;
        console.log('Writing to ', newFilePath);
        writeFileSync(newFilePath, css, { encoding: 'utf8' });
    });
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
watchLessDirectory(SOURCE_PATH, rebuildCallback);
