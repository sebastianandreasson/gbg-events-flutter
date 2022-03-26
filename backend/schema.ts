import { list } from '@keystone-6/core'
import { password, text } from '@keystone-6/core/fields'

export const lists = {
  User: list({
    fields: {
      email: text({ isIndexed: 'unique', validation: { isRequired: true } }),
      password: password({ validation: { isRequired: true } }),
    },
  }),
}
