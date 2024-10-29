-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql:3306
-- Generation Time: Oct 22, 2024 at 06:07 PM
-- Server version: 9.0.1
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `se`
--

-- --------------------------------------------------------

--
-- Table structure for table `absences`
--

CREATE TABLE `absences` (
  `absenceID` varchar(10) NOT NULL,
  `absenceType` enum('late','absence') NOT NULL,
  `status` enum('in branch','out branch','FC','success','CHECK') NOT NULL,
  `userIDsend` varchar(10) NOT NULL,
  `userIDchange` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `absences`
--

INSERT INTO `absences` (`absenceID`, `absenceType`, `status`, `userIDsend`, `userIDchange`) VALUES
('AB001', 'absence', 'FC', 'E01B01', 'E02B02'),
('AB002', 'late', 'FC', 'E02B02', NULL),
('AB003', 'absence', 'FC', 'E02B02', NULL),
('AB005', 'late', 'in branch', 'E01B01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `branchID` varchar(10) NOT NULL,
  `branchName` varchar(30) NOT NULL,
  `branchAddress` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`branchID`, `branchName`, `branchAddress`) VALUES
('B01', 'กรุงเทพ', 'เจริญกรุง 44 กทม. 10800'),
('B02', 'นนทบุรี', '7/20 นนทบุรี 11130'),
('B03', 'Example Branch', '123 Example St');

-- --------------------------------------------------------

--
-- Table structure for table `fcdetails`
--

CREATE TABLE `fcdetails` (
  `fcDetailID` varchar(10) NOT NULL,
  `userID` varchar(10) NOT NULL,
  `branchID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `fcdetails`
--

INSERT INTO `fcdetails` (`fcDetailID`, `userID`, `branchID`) VALUES
('FC01', 'E01B01', 'B01'),
('FC02', 'E02B02', 'B02');

-- --------------------------------------------------------

--
-- Table structure for table `managerreplytofcs`
--

CREATE TABLE `managerreplytofcs` (
  `replyID` int NOT NULL,
  `userID` varchar(10) DEFAULT NULL,
  `absenceID` varchar(10) DEFAULT NULL,
  `status` enum('yes','no') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `scheduleID` varchar(10) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`scheduleID`, `date`) VALUES
('SC01', '2024-03-13'),
('SC02', '2024-03-14'),
('SC03', '2024-03-15'),
('SC04', '2024-03-20'),
('SC05', '2024-03-11');

-- --------------------------------------------------------

--
-- Table structure for table `shiftdetails`
--

CREATE TABLE `shiftdetails` (
  `shiftDetailID` varchar(10) NOT NULL,
  `shiftID` varchar(10) NOT NULL,
  `userID` varchar(10) NOT NULL,
  `status` enum('OT','shift') NOT NULL,
  `statusCL` enum('yes','no') NOT NULL,
  `absenceID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `shiftdetails`
--

INSERT INTO `shiftdetails` (`shiftDetailID`, `shiftID`, `userID`, `status`, `statusCL`, `absenceID`) VALUES
('SD01', 'S01', 'E01B01', 'OT', 'yes', NULL),
('SD02', 'S02', 'E02B02', 'shift', 'yes', 'AB001'),
('SD03', 'S03', 'E02B02', 'OT', 'yes', NULL),
('SD04', 'S02', 'E01B02', 'shift', 'yes', NULL),
('SD05', 'S05', 'E02B02', 'shift', 'yes', 'AB003'),
('SD06', 'S01', 'E01B03', 'shift', 'yes', NULL),
('SD07', 'S06', 'E01B03', 'shift', 'yes', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `shiftID` varchar(10) NOT NULL,
  `scheduleID` varchar(10) NOT NULL,
  `timeID` varchar(10) NOT NULL,
  `branchID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`shiftID`, `scheduleID`, `timeID`, `branchID`) VALUES
('S01', 'SC01', 'T01', 'B01'),
('S02', 'SC02', 'T02', 'B01'),
('S03', 'SC02', 'T01', 'B02'),
('S04', 'SC03', 'T01', 'B02'),
('S05', 'SC03', 'T03', 'B02'),
('S06', 'SC05', 'T03', 'B01');

-- --------------------------------------------------------

--
-- Table structure for table `typeroles`
--

CREATE TABLE `typeroles` (
  `roleID` varchar(10) NOT NULL,
  `roleName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `typeroles`
--

INSERT INTO `typeroles` (`roleID`, `roleName`) VALUES
('1', 'Admin'),
('2', 'Manager'),
('3', 'Employee');

-- --------------------------------------------------------

--
-- Table structure for table `typetimes`
--

CREATE TABLE `typetimes` (
  `timeID` varchar(10) NOT NULL,
  `timeStart` time NOT NULL,
  `timeEnd` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `typetimes`
--

INSERT INTO `typetimes` (`timeID`, `timeStart`, `timeEnd`) VALUES
('T01', '05:30:00', '14:30:00'),
('T02', '14:30:00', '23:30:00'),
('T03', '23:30:00', '08:30:00'),
('T04', '01:00:00', '08:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` varchar(10) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `surName` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `dateBirth` date NOT NULL,
  `passwordUser` varchar(100) NOT NULL,
  `branchID` varchar(10) DEFAULT NULL,
  `roleID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `firstName`, `surName`, `email`, `dateBirth`, `passwordUser`, `branchID`, `roleID`) VALUES
('E01B01', 'aun', 'art', 'aun@ku.th', '2024-03-12', 'aun', 'B01', '1'),
('E01B02', 'Brown', 'Johb', 'Brown.Johb@example.com', '2002-10-31', 'Brown123', 'B01', '3'),
('E01B03', 'Jogn', 'Hond', 'Jogn.Hond@example.com', '2002-10-31', 'Jogn1234', 'B01', '3'),
('E02B02', 'kanjana', 'saengt', 'kan@ku.th', '2024-01-15', 'Kan12345', 'B02', '1'),
('E02B03', 'Sorawit', 'Chueachual', 'Soraiwt.ch@gmail.com', '2024-03-14', 'Bew12345', 'B02', '3'),
('M01B01', 'aunlaphat', 'artsuriyong', 'a.aunaun@ku.th', '2002-06-18', 'faza1234', 'B01', '2'),
('M01B02', 'jee', 'kaew', 'jee@email.com', '2024-03-05', 'Test1234', 'B02', '2'),
('S1', 'tes1', 'test1', 'sorawitchueachual70@gmail.com', '1990-01-01', '2746ozzyx', 'B01', '1'),
('S2', 'Sorawit', 'Chueachual', 'sorawit.chueachual.work@gmail.com', '2024-10-13', '2746ozzyx', 'B02', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absences`
--
ALTER TABLE `absences`
  ADD PRIMARY KEY (`absenceID`),
  ADD KEY `userIDsend` (`userIDsend`),
  ADD KEY `userIDchange` (`userIDchange`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`branchID`);

--
-- Indexes for table `fcdetails`
--
ALTER TABLE `fcdetails`
  ADD PRIMARY KEY (`fcDetailID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `branchID` (`branchID`);

--
-- Indexes for table `managerreplytofcs`
--
ALTER TABLE `managerreplytofcs`
  ADD PRIMARY KEY (`replyID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `absenceID` (`absenceID`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`scheduleID`);

--
-- Indexes for table `shiftdetails`
--
ALTER TABLE `shiftdetails`
  ADD PRIMARY KEY (`shiftDetailID`),
  ADD KEY `shiftID` (`shiftID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `absenceID` (`absenceID`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`shiftID`),
  ADD KEY `scheduleID` (`scheduleID`),
  ADD KEY `timeID` (`timeID`),
  ADD KEY `branchID` (`branchID`);

--
-- Indexes for table `typeroles`
--
ALTER TABLE `typeroles`
  ADD PRIMARY KEY (`roleID`);

--
-- Indexes for table `typetimes`
--
ALTER TABLE `typetimes`
  ADD PRIMARY KEY (`timeID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`),
  ADD KEY `branchID` (`branchID`),
  ADD KEY `roleID` (`roleID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `managerreplytofcs`
--
ALTER TABLE `managerreplytofcs`
  MODIFY `replyID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absences`
--
ALTER TABLE `absences`
  ADD CONSTRAINT `absences_ibfk_1` FOREIGN KEY (`userIDsend`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `absences_ibfk_2` FOREIGN KEY (`userIDchange`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `fcdetails`
--
ALTER TABLE `fcdetails`
  ADD CONSTRAINT `fcdetails_ibfk_3` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fcdetails_ibfk_4` FOREIGN KEY (`branchID`) REFERENCES `branches` (`branchID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `managerreplytofcs`
--
ALTER TABLE `managerreplytofcs`
  ADD CONSTRAINT `managerreplytofcs_ibfk_3` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `managerreplytofcs_ibfk_4` FOREIGN KEY (`absenceID`) REFERENCES `absences` (`absenceID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shiftdetails`
--
ALTER TABLE `shiftdetails`
  ADD CONSTRAINT `shiftdetails_ibfk_4` FOREIGN KEY (`shiftID`) REFERENCES `shifts` (`shiftID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `shiftdetails_ibfk_5` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `shiftdetails_ibfk_6` FOREIGN KEY (`absenceID`) REFERENCES `absences` (`absenceID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shifts`
--
ALTER TABLE `shifts`
  ADD CONSTRAINT `shifts_ibfk_4` FOREIGN KEY (`scheduleID`) REFERENCES `schedules` (`scheduleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `shifts_ibfk_5` FOREIGN KEY (`timeID`) REFERENCES `typetimes` (`timeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `shifts_ibfk_6` FOREIGN KEY (`branchID`) REFERENCES `branches` (`branchID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`branchID`) REFERENCES `branches` (`branchID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_4` FOREIGN KEY (`roleID`) REFERENCES `typeroles` (`roleID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
