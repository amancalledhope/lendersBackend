-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 19, 2022 at 01:46 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lenders_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `item_id` int(11) NOT NULL,
  `item_type_id` int(11) NOT NULL,
  `item_desc` varchar(180) NOT NULL,
  `item_location` varchar(50) NOT NULL,
  `item_price` int(11) DEFAULT NULL,
  `item_avalaible_from` date DEFAULT NULL,
  `item_avalaible_to` date DEFAULT NULL,
  `item_lender_id` int(11) DEFAULT NULL,
  `item_status` int(11) NOT NULL,
  `item_borrower_id` int(11) DEFAULT NULL,
  `posted_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `report_id` int(11) NOT NULL,
  `reporter_id` int(11) DEFAULT NULL,
  `reported_item_id` int(11) DEFAULT NULL,
  `reported_request_id` int(11) DEFAULT NULL,
  `reported_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `request_number` int(11) DEFAULT NULL,
  `request_id` int(11) NOT NULL,
  `request_name` varchar(30) DEFAULT NULL,
  `request_description` varchar(180) DEFAULT NULL,
  `request_date_from` date DEFAULT NULL,
  `request_date_to` date DEFAULT NULL,
  `request_borrower_id` int(11) DEFAULT NULL,
  `request_lender_id` int(11) DEFAULT NULL,
  `posted_date` date DEFAULT NULL,
  `request_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(30) NOT NULL,
  `user_id` int(11) NOT NULL,
  `NRC` varchar(10) DEFAULT NULL,
  `phone_number` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `location` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `item_lender_id` (`item_lender_id`),
  ADD KEY `item_borrower_id` (`item_borrower_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `reporter_id` (`reporter_id`),
  ADD KEY `reported_item_id` (`reported_item_id`),
  ADD KEY `reported_request_id` (`reported_request_id`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `request_lender_id` (`request_lender_id`),
  ADD KEY `request_borrower_id` (`request_borrower_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`item_lender_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `item_ibfk_2` FOREIGN KEY (`item_borrower_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`reported_item_id`) REFERENCES `item` (`item_id`),
  ADD CONSTRAINT `report_ibfk_3` FOREIGN KEY (`reported_request_id`) REFERENCES `request` (`request_id`);

--
-- Constraints for table `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `request_ibfk_1` FOREIGN KEY (`request_lender_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `request_ibfk_2` FOREIGN KEY (`request_borrower_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
