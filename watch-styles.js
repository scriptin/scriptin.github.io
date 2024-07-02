import { watch } from 'node:fs';
import { execSync } from 'node:child_process';

watch('./less', (eventType, filename) => {
    if (!filename) return;
    const isTemporary = filename.endsWith('~');
    const isStyle = filename.endsWith('.less') || filename.endsWith('.less');
    if (isTemporary || !isStyle) return;

    if (eventType === 'change') {
        console.log('Rebuilding styles...');
        execSync('lessc less/style.less --clean-css css/style.min.css');
    } else {
        console.log(`Ignored event type ${eventType} on file ${filename}`);
    }
});
