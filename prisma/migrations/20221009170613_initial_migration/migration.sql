-- CreateEnum
CREATE TYPE "additional_reference_type" AS ENUM ('CO_CHECK', 'ELEC_CHECK', 'EPC', 'GAS_CHECK', 'GAS_CONTRACT', 'INSURANCE', 'MORTGAGE_STATEMENT', 'OTHER', 'SMOKE_CHECK');

-- CreateEnum
CREATE TYPE "blog_role" AS ENUM ('ROLE_METRICS', 'ROLE_ADMIN', 'ROLE_USER', 'ROLE_LANDLORD', 'ROLE_TENANT');

-- CreateEnum
CREATE TYPE "blog_type" AS ENUM ('NEWS', 'MAINTENANCE', 'OTHER', '');

-- CreateEnum
CREATE TYPE "property_type" AS ENUM ('APARTMENT', 'TERRACED', 'SEMI-DETACHED', 'DETACHED', 'OTHER');

-- CreateTable
CREATE TABLE "additional_reference" (
    "id" BIGSERIAL NOT NULL,
    "user_id" DECIMAL NOT NULL,
    "property_id" DECIMAL NOT NULL,
    "type" "additional_reference_type",
    "description" VARCHAR(100) NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "annual_fee" DECIMAL(5,2),
    "monthly_fee" DECIMAL(6,2),
    "balance" DECIMAL(8,2),
    "rate" DECIMAL(5,2),
    "payment_date" SMALLINT,
    "company" VARCHAR(100),
    "company_ref" VARCHAR(100),
    "dd_ref" VARCHAR(100),

    CONSTRAINT "idx_20790_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "blog" (
    "id" BIGSERIAL NOT NULL,
    "type" "blog_type" NOT NULL,
    "role" "blog_role" NOT NULL,
    "effective_from" DATE,
    "effective_to" DATE,
    "title" VARCHAR(100) NOT NULL,
    "content" VARCHAR(124) NOT NULL,

    CONSTRAINT "idx_20797_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "finance" (
    "id" BIGSERIAL NOT NULL,
    "user_id" DECIMAL NOT NULL,
    "property_id" DECIMAL NOT NULL,
    "description" VARCHAR(100),
    "amount" DECIMAL(6,2) NOT NULL,
    "date" DATE NOT NULL,
    "type" VARCHAR(100),
    "until" DATE,

    CONSTRAINT "idx_20802_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "owner" (
    "id" BIGSERIAL NOT NULL,
    "user_id" DECIMAL NOT NULL,
    "firstname" VARCHAR(100) NOT NULL,
    "lastname" VARCHAR(100) NOT NULL,

    CONSTRAINT "idx_20809_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "property" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "address" VARCHAR(100) NOT NULL,
    "postcode" VARCHAR(20) NOT NULL,
    "type" "property_type",
    "bedrooms" SMALLINT,
    "purchase_date" DATE NOT NULL,
    "purchase_amount" DECIMAL(9,2) NOT NULL,
    "sold_date" DATE,
    "current_value" DECIMAL(9,2) NOT NULL,

    CONSTRAINT "idx_20816_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "property_owner" (
    "id" BIGSERIAL NOT NULL,
    "user_id" DECIMAL NOT NULL,
    "property_id" DECIMAL NOT NULL,
    "owner_id" BIGINT NOT NULL,
    "start_date" DATE,
    "end_date" DATE,
    "percentage" DECIMAL(5,2) NOT NULL,

    CONSTRAINT "idx_20823_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role" (
    "id" BIGSERIAL NOT NULL,
    "user_id" DECIMAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "idx_20830_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tenancy" (
    "id" BIGSERIAL NOT NULL,
    "user_id" DECIMAL NOT NULL,
    "property_id" DECIMAL NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "rent_date" SMALLINT NOT NULL,
    "rent" DECIMAL(6,2) NOT NULL,
    "deposit" DECIMAL(6,2) NOT NULL,
    "deposit_id" VARCHAR(100) NOT NULL,

    CONSTRAINT "idx_20837_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "password" VARCHAR(100) NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "enabled" BOOLEAN NOT NULL,

    CONSTRAINT "idx_20844_primary" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_20790_property_id" ON "additional_reference"("property_id");

-- CreateIndex
CREATE INDEX "idx_20790_user_id" ON "additional_reference"("user_id");

-- CreateIndex
CREATE INDEX "idx_20802_property_id" ON "finance"("property_id");

-- CreateIndex
CREATE INDEX "idx_20802_user_id" ON "finance"("user_id");

-- CreateIndex
CREATE INDEX "idx_20809_user_id" ON "owner"("user_id");

-- CreateIndex
CREATE INDEX "idx_20816_user_id" ON "property"("user_id");

-- CreateIndex
CREATE INDEX "idx_20823_owner_id" ON "property_owner"("owner_id");

-- CreateIndex
CREATE INDEX "idx_20823_property_id" ON "property_owner"("property_id");

-- CreateIndex
CREATE INDEX "idx_20823_user_id" ON "property_owner"("user_id");

-- CreateIndex
CREATE INDEX "idx_20830_user_id" ON "role"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "idx_20830_email" ON "role"("user_id", "name");

-- CreateIndex
CREATE INDEX "idx_20837_property_id" ON "tenancy"("property_id");

-- CreateIndex
CREATE INDEX "idx_20837_user_id" ON "tenancy"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "idx_20844_email" ON "user"("email");

-- AddForeignKey
ALTER TABLE "property" ADD CONSTRAINT "property_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "property_owner" ADD CONSTRAINT "fk_property_owner_owner" FOREIGN KEY ("owner_id") REFERENCES "owner"("id") ON DELETE CASCADE ON UPDATE CASCADE;
