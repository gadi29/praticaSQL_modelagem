CREATE DATABASE bank_practice;

CREATE TABLE "customers" (
	id SERIAL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	"cpf" TEXT UNIQUE NOT NULL,
	"email" TEXT UNIQUE NOT NULL,
	"password" TEXT NOT NULL
);

CREATE TABLE "customersPhone" (
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers(id),
	"number" TEXT UNIQUE NOT NULL,
	"type" TEXT NOT NULL
);

CREATE TABLE "states" (
	id SERIAL PRIMARY KEY,
	"name" TEXT UNIQUE NOT NULL
);

CREATE TABLE "cities" (
	id SERIAL PRIMARY KEY,
	"name" TEXT UNIQUE NOT NULL,
	"stateId" INTEGER NOT NULL REFERENCES states(id)
);

CREATE TABLE "customerAddresses" (
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers(id),
	"street" TEXT NOT NULL,
	"number" INTEGER NOT NULL,
	"complement" TEXT,
	"postalCode" TEXT NOT NULL,
	"cityId" INTEGER NOT NULL REFERENCES cities(id)
);

CREATE TABLE "bankAccount" (
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers(id),
	"accountNumber" TEXT UNIQUE NOT NULL,
	"agency" TEXT NOT NULL,
	"openDate" TIMESTAMP NOT NULL DEFAULT NOW(),
	"closeDate" TIMESTAMP
);

CREATE TABLE "transactions" (
	id SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"(id),
	"amount" INTEGER NOT NULL,
	"type" TEXT NOT NULL,
	"time" TIME NOT NULL DEFAULT NOW(),
	"description" TEXT,
	"cancelled" BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE "creditCards" (
	id SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"(id),
	"name" TEXT NOT NULL,
	"number" TEXT UNIQUE NOT NULL,
	"securityCode" TEXT UNIQUE NOT NULL,
	"expirationMonth" INTEGER NOT NULL,
	"expirationYear" INTEGER NOT NULL,
	"password" TEXT NOT NULL,
	"limit" INTEGER NOT NULL
);