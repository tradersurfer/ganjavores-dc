import { createClient } from '@supabase/supabase-js'
import { readdir, readFile, stat } from 'fs/promises'
import { join, basename } from 'path'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
)

const bucket = supabase.storage.from('product-images')
const publicDir = './public/products'
const categories = ['flower', 'vapes', 'edibles', 'pre-rolls']

async function getFiles(dir) {
  const files = []
  for (const cat of categories) {
    try {
      const entries = await readdir(join(publicDir, cat))
      for (const entry of entries) {
        if (entry.endsWith('.png')) {
          files.push({ cat, file: entry, path: join(publicDir, cat, entry) })
        }
      }
    } catch {}
  }
  return files
}

async function upload() {
  const files = await getFiles(publicDir)
  console.log(`Found ${files.length} images`)
  
  let uploaded = 0
  for (const { cat, file, path } of files) {
    try {
      const buffer = await readFile(path)
      const { error } = await bucket.upload(`${cat}/${file}`, buffer, { upsert: true })
      if (!error) uploaded++
    } catch {}
  }
  console.log(`Uploaded ${uploaded} images`)
}

upload()
