/*
  Warnings:

  - Added the required column `name` to the `pet` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `pet` DROP FOREIGN KEY `pet_user_id_fkey`;

-- DropIndex
DROP INDEX `pet_user_id_fkey` ON `pet`;

-- AlterTable
ALTER TABLE `pet` ADD COLUMN `name` VARCHAR(32) NOT NULL,
    ADD COLUMN `status` ENUM('adopted', 'stray') NOT NULL DEFAULT 'stray',
    MODIFY `user_id` INTEGER NULL;

-- AddForeignKey
ALTER TABLE `pet` ADD CONSTRAINT `pet_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
