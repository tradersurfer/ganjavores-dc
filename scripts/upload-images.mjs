import { createClient } from '@supabase/supabase-js'
import { readdirSync, readFileSync } from 'fs'
import { join } from 'path'

const supabase = createClient(
  'https://ogaisocuxygcembgodna.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9nYWlzb2N1eXFnZW1iZ29kbmEiLCJhdWQiOiJzdXBhYmFzZS1yZWxlYXNlcmQiLCJpYXQiOjE3NTgyNjk4MDB9.Mo1Y'
)
const bucket = supabase.storage.from('product-images')
const publicDir = './public/products'
const categories = ['flower', 'vapes', 'edibles', 'pre-rolls']

async function upload() {
  let uploaded = 0
  let failed = 0

  for (const cat of categories) {
    try {
      const files = readdirSync(join(publicDir, cat))
      for (const file of files) {
        if (!file.endsWith('.png')) continue
        try {
          const buffer = readFileSync(join(publicDir, cat, file))
          const { error } = await bucket.upload(cat + '/' + file, buffer, { upsert: true })
          if (!error) {
            uploaded++
          } else {
            failed++
          }
        } catch {
          failed++
        }
      }
    } catch {}
  }
  console.log('Uploaded: ' + uploaded + ', Failed: ' + failed)
}
upload()
