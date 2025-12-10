#!/usr/bin/env node
// check-vobsub.js
import fs from 'fs/promises';
import path from 'path';
import { execFile } from 'child_process';
import { promisify } from 'util';

const exec = promisify(execFile);
const VIDEO_EXTS = ['.mkv', '.mp4', '.m4v'];

async function findVideoFiles(dir) {
  let results = [];
  const entries = await fs.readdir(dir, { withFileTypes: true });

  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      results = results.concat(await findVideoFiles(fullPath));
    } else if (VIDEO_EXTS.includes(path.extname(entry.name).toLowerCase())) {
      results.push(fullPath);
    }
  }
  return results;
}

async function hasVobSub(filePath) {
  try {
    const { stdout } = await exec('ffprobe', [
      '-v', 'error',
      '-select_streams', 's',
      '-show_entries', 'stream=index,codec_name',
      '-of', 'json',
      filePath
    ]);
    const data = JSON.parse(stdout);
    return (data.streams || []).some(s => s.codec_name === 'dvd_subtitle');
  } catch (err) {
    console.error(`Failed to probe ${filePath}:`, err.message);
    return false;
  }
}

async function main(targetDir) {
  const videoFiles = await findVideoFiles(targetDir);
  const filesWithVobSub = [];

  for (const file of videoFiles) {
    console.log('.')
    const hasSub = await hasVobSub(file);
    if (hasSub) {
      filesWithVobSub.push(file);
    }
  }

  console.log('--------Files with VobSub subtitles:');
  filesWithVobSub.forEach(f => console.log(f));
}

const dir = process.argv[2];
if (!dir) {
  console.error('Usage: node check-vobsub.js <directory>');
  process.exit(1);
}

main(dir).catch(err => {
  console.error('Error:', err);
  process.exit(1);
});

