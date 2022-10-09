import { PrismaClient } from '@prisma/client'
import dateFormat, { masks } from "dateformat";

const prisma = new PrismaClient()

async function main() {

  const users = await prisma.user.findUnique({
    include: {
      properties: true
    },
    where: {
      id: 1
    },
  })
  console.dir(users, { depth: null })  

  const finances = await prisma.finance.findMany({
    where: {
      user_id: 1,     
      date: {
        gte: new Date('2022-10-01')
      },
      amount: {
        gt: 10
      }
    },
    skip: 0,
    take: 10,
    orderBy: {
      date: 'desc'
    }
  })
  console.dir(finances.map((f) => `${dateFormat(f.date,'isoDate')} ${f.description} ${f.amount}`), { depth: null })  

}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })