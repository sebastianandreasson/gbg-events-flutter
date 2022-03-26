import 'dotenv/config'
import { config as keystoneConfig } from '@keystone-6/core'
import { statelessSessions } from '@keystone-6/core/session'
import { createAuth } from '@keystone-6/auth'
import { lists } from './schema'

const { withAuth } = createAuth({
  listKey: 'User',
  identityField: 'email',
  secretField: 'password',
  initFirstItem: {
    fields: ['email', 'password'],
    skipKeystoneWelcome: true,
  },
})

let sessionMaxAge = 60 * 60 * 24 * 30 // 30 days
let sessionSecret = '-- DEV COOKIE SECRET; CHANGE ME --'

export const config = keystoneConfig({
  db: {
    provider: 'sqlite',
    url: process.env.DATABASE_URL || 'file:./keystone.db',
  },
  lists,
  session: statelessSessions({
    secure: false,
    maxAge: sessionMaxAge,
    secret: sessionSecret!,
  }),
  images: {
    upload: 'local',
    local: {
      storagePath: 'public/images',
      baseUrl: '/images',
    },
  },
  server: {
    cors: {
      origin: '*',
    },
  },
})

export default withAuth(config)
