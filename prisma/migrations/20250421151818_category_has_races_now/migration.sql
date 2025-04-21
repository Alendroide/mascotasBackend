/*
  Warnings:

  - You are about to drop the column `category_id` on the `pet` table. All the data in the column will be lost.
  - Added the required column `category_id` to the `race` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `pet` DROP FOREIGN KEY `pet_category_id_fkey`;

-- DropIndex
DROP INDEX `pet_category_id_fkey` ON `pet`;

-- AlterTable
ALTER TABLE `pet` DROP COLUMN `category_id`;

-- AlterTable
ALTER TABLE `race` ADD COLUMN `category_id` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `race` ADD CONSTRAINT `race_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `category`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
