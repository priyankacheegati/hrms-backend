-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 27, 2025 at 11:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hr_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` enum('Present','Absent','Leave') DEFAULT NULL,
  `clock_in` datetime DEFAULT NULL,
  `clock_out` datetime DEFAULT NULL,
  `leave_reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `user_id`, `date`, `status`, `clock_in`, `clock_out`, `leave_reason`) VALUES
(1, 10, '2025-09-17', 'Present', NULL, NULL, NULL),
(3, 11, '2025-09-17', 'Leave', NULL, NULL, NULL),
(4, 12, '2025-09-17', 'Present', NULL, NULL, NULL),
(6, 12, '2025-09-18', 'Leave', NULL, NULL, NULL),
(9, 10, '2025-09-18', 'Present', NULL, NULL, NULL),
(12, 10, '2025-09-19', 'Leave', NULL, NULL, NULL),
(13, 11, '2025-09-19', 'Leave', NULL, NULL, NULL),
(16, 12, '2025-09-20', 'Leave', NULL, NULL, NULL),
(18, 10, '2025-09-20', 'Leave', NULL, NULL, NULL),
(19, 10, '2025-09-22', 'Leave', NULL, NULL, NULL),
(20, 10, '2025-09-23', 'Present', NULL, NULL, NULL),
(21, 10, '2025-09-23', 'Leave', NULL, NULL, NULL),
(22, 10, '2025-09-24', 'Present', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Manager');

-- --------------------------------------------------------

--
-- Table structure for table `department_employees`
--

CREATE TABLE `department_employees` (
  `id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department_employees`
--

INSERT INTO `department_employees` (`id`, `department_id`, `employee_id`) VALUES
(5, 2, 13),
(12, 3, 9),
(13, 1, 10),
(14, 1, 11),
(15, 1, 12);

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `name`, `email`, `phone`, `status`, `source`) VALUES
(1, 'priyanka', 'priyanka@gmail.com', '1324343', NULL, 'aaa'),
(2, 'suvarna', 'suvarna@gmail.com', '123345567', NULL, 'sdfdff'),
(3, 'asdfghj', 'asd@gmail.com', '1234567', NULL, 'sdfgh'),
(4, 'sdfg', 'assdfghjkd@gmail.com', '12345674567', NULL, 'sdfgh56'),
(5, 'sdfg', 'assdfghjkd@gmail.com', '12345674567', NULL, 'sdfgh56'),
(6, 'sdfg', 'assdfghjkd@gmail.com', '12345674567', NULL, 'sdfgh56'),
(7, 'sdfg', 'assdfghjkd@gmail.com', '12345674567', NULL, 'sdfgh56'),
(8, 'abcd', 'abcd@gmail.com', '111111111', NULL, 'aaa'),
(31, '--', 'qer@gmail.com', '6543', NULL, 'sdf'),
(34, 'dfgg', 'priyanka@gmail.com', '1324343', 'Active', 'vh'),
(35, 'Suvarna', 'suvarna@gmail.com', '9876543210', 'Active', 'Website'),
(36, 'Priyanka', 'priyanka@gmail.com', '9123456780', 'Active', 'Referral'),
(37, 'Ravi', 'ravi@gmail.com', '9988776655', 'Active', 'Social Media'),
(38, 'Anjali', 'anjali@gmail.com', '9871234560', 'Active', 'Advertisement'),
(39, 'Karthik', 'karthik@gmail.com', '9123987654', 'Active', 'Website'),
(40, 'Sneha', 'sneha@gmail.com', '9876541230', 'Active', 'Referral'),
(41, 'Ajay', 'ajay@gmail.com', '9988771122', 'Active', 'Social Media'),
(42, 'Deepika', 'deepika@gmail.com', '9123459876', 'Active', 'Advertisement'),
(45, 'Suvarna', 'suvarna@gmail.com', '9876543210', 'Active', 'Website'),
(46, 'Priyanka', 'priyanka@gmail.com', '9123456780', 'Active', 'Referral'),
(47, 'Ravi', 'ravi@gmail.com', '9988776655', 'Active', 'Social Media'),
(48, 'Anjali', 'anjali@gmail.com', '9871234560', 'Active', 'Advertisement'),
(49, 'Karthik', 'karthik@gmail.com', '9123987654', 'Active', 'Website'),
(50, 'Sneha', 'sneha@gmail.com', '9876541230', 'Active', 'Referral'),
(51, 'Ajay', 'ajay@gmail.com', '9988771122', 'Active', 'Social Media'),
(52, 'Deepika', 'deepika@gmail.com', '9123459876', 'Active', 'Advertisement'),
(53, 'Suresh', 'suresh@gmail.com', '9871239876', 'Active', 'Website'),
(54, 'Pooja', 'pooja@gmail.com', '9988112233', 'Active', 'Referral'),
(55, 'Suvarna', 'suvarna@gmail.com', '9876543210', 'Active', 'Website'),
(56, 'Priyanka', 'priyanka@gmail.com', '9123456780', 'Active', 'Referral'),
(57, 'Ravi', 'ravi@gmail.com', '9988776655', 'Active', 'Social Media'),
(58, 'Anjali', 'anjali@gmail.com', '9871234560', 'Active', 'Advertisement'),
(59, 'Karthik', 'karthik@gmail.com', '9123987654', 'Active', 'Website'),
(60, 'Sneha', 'sneha@gmail.com', '9876541230', 'Active', 'Referral'),
(61, 'Ajay', 'ajay@gmail.com', '9988771122', 'Active', 'Social Media'),
(62, 'Deepika', 'deepika@gmail.com', '9123459876', 'Active', 'Advertisement'),
(63, 'Suresh', 'suresh@gmail.com', '9871239876', 'Active', 'Website');

-- --------------------------------------------------------

--
-- Table structure for table `leave_requests`
--

CREATE TABLE `leave_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `approved_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leave_requests`
--

INSERT INTO `leave_requests` (`id`, `user_id`, `date`, `reason`, `status`, `created_at`, `approved_date`) VALUES
(7, 12, '2025-09-20', 'fever', 'approved', '2025-09-20 06:46:32', NULL),
(8, 11, '2025-09-20', 'jjjj', 'approved', '2025-09-20 06:58:36', '2025-09-20'),
(9, 10, '2025-09-20', 'fever', 'approved', '2025-09-20 12:27:01', '2025-09-20'),
(10, 10, '2025-09-22', 'fever', 'approved', '2025-09-22 07:28:45', '2025-09-22'),
(11, 10, '2025-09-23', 'hh', 'approved', '2025-09-23 07:15:39', '2025-09-23');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `message`, `timestamp`) VALUES
(1, 10, 12, 'hiiii', '2025-09-23 12:40:17'),
(2, 12, 10, 'ela vunnav', '2025-09-23 12:42:31'),
(3, 10, 12, 'did you complete your project', '2025-09-23 12:44:29'),
(4, 10, 12, 'hey', '2025-09-23 17:38:27');

-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

CREATE TABLE `payroll` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `month` date DEFAULT NULL,
  `basic` decimal(10,2) NOT NULL,
  `bonus` decimal(10,2) DEFAULT 0.00,
  `total` decimal(10,2) GENERATED ALWAYS AS (`basic` + `bonus`) STORED,
  `status` enum('Pending','Paid') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payroll`
--

INSERT INTO `payroll` (`id`, `user_id`, `month`, `basic`, `bonus`, `status`, `created_at`, `updated_at`) VALUES
(7, 11, '2025-08-05', 30000.00, 600.00, 'Paid', '2025-09-22 14:19:50', '2025-09-22 17:13:54'),
(8, 10, '2025-07-05', 30000.00, 3.00, 'Paid', '2025-09-22 17:30:26', '2025-09-22 17:30:32'),
(9, 12, '2025-08-05', 15000.00, 0.00, 'Paid', '2025-09-23 11:47:51', '2025-09-23 11:48:59');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `priority` enum('High','Medium','Low') DEFAULT 'Medium',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `assigned_to` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `status`, `priority`, `description`, `created_at`, `updated_at`, `assigned_to`) VALUES
(2, 'admin daashboard', 'Active', 'High', 'dasdfggh', '2025-09-24 05:22:35', '2025-09-24 05:22:35', NULL),
(11, 'hrms', 'Active', 'Low', 'ggggggggggggg', '2025-09-24 06:23:45', '2025-09-24 06:23:45', 'suvarna posimsetti, bhargavi, priyanka, supraja, h'),
(12, 'hrms', 'Active', 'Low', 'aass', '2025-09-24 06:29:09', '2025-09-24 06:29:09', 'suvarna posimsetti, bhargavi, priyanka, supraja'),
(13, 'hrms', 'Active', 'Low', 'ssssssssssss', '2025-09-24 06:46:55', '2025-09-24 06:46:55', 'priyanka, supraja'),
(14, 'gg', 'Active', 'Low', 'dddd', '2025-09-25 08:46:54', '2025-09-25 08:46:54', 'Mee, laxman, suvarna posimsetti, bhargavi, priyanka');

-- --------------------------------------------------------

--
-- Table structure for table `project_assignments`
--

CREATE TABLE `project_assignments` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_assignments`
--

INSERT INTO `project_assignments` (`id`, `project_id`, `user_id`, `assigned_at`) VALUES
(4, 11, 10, '2025-09-24 06:23:45'),
(5, 11, 11, '2025-09-24 06:23:45'),
(6, 11, 12, '2025-09-24 06:23:45'),
(7, 11, 13, '2025-09-24 06:23:45'),
(8, 11, 14, '2025-09-24 06:23:45'),
(9, 12, 10, '2025-09-24 06:29:09'),
(10, 12, 11, '2025-09-24 06:29:09'),
(11, 12, 12, '2025-09-24 06:29:09'),
(12, 12, 13, '2025-09-24 06:29:09'),
(13, 13, 12, '2025-09-24 06:46:55'),
(14, 13, 13, '2025-09-24 06:46:55'),
(15, 14, 8, '2025-09-25 08:46:54'),
(16, 14, 9, '2025-09-25 08:46:54'),
(17, 14, 10, '2025-09-25 08:46:54'),
(18, 14, 11, '2025-09-25 08:46:54'),
(19, 14, 12, '2025-09-25 08:46:54');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Active',
  `department` varchar(100) DEFAULT NULL,
  `documents` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `role`, `password`, `join_date`, `phone`, `country`, `image`, `status`, `department`, `documents`) VALUES
(2, 'Bob', 'bob@example.com', 'employee', 'suvvu', NULL, '67867577777', 'India', NULL, 'Active', NULL, '[]'),
(4, 'varun', 'varun@gmail.com', 'admin', 'var', NULL, NULL, 'India', NULL, 'Active', NULL, '[]'),
(8, 'Mee', 'ht@gmail.com', 'manager', NULL, NULL, NULL, 'India', NULL, 'Active', NULL, '[]'),
(9, 'laxman', 'laxman@gmail.com', 'manager', 'lax', NULL, NULL, 'India', NULL, 'Active', NULL, '[]'),
(10, 'suvarna posimsetti', 'suvarna@gmail.com', 'Employee', 'suvvu', '2025-08-15', NULL, NULL, 'WhatsApp_Image_2025-09-01_at_3.56.45_PM.jpeg', 'Active', NULL, '[\"/static/uploads/Project_Documentation.pdf\", \"/static/uploads/Project_Documentation.pdf\", \"work_logs_report_1.pdf\"]'),
(11, 'bhargavi', 'bhargavi@gmail.com', 'employee', 'bannu', NULL, NULL, 'India', NULL, 'Active', NULL, '[]'),
(12, 'priyanka', 'priyanka@gmail.com', 'employee', 'priya', NULL, NULL, 'India', 'ChatGPT_Image_Sep_18_2025_11_34_37_AM.png', 'Active', NULL, '[]'),
(13, 'supraja', 'supraja@gmail.com', 'hr', 'sup', NULL, NULL, 'India', NULL, 'Active', NULL, '[]'),
(14, 'h', 'j@gmail.com', 'Employee', 'default123', '2025-09-19', '', '', NULL, 'active', NULL, '[]'),
(15, 'rdr', 's@gmail.com', 'Employee', 'default123', '2025-09-19', '', '', NULL, 'active', NULL, '[]'),
(16, 'ed', 'a@gmail.com', '', 'default123', '2025-09-20', '', 'India', NULL, 'active', NULL, '[]'),
(28, 'wq', 'qw@gmail.com', 'Employee', 'suvvu', '2025-09-22', '65633333', 'India', NULL, 'active', 'IT', '[]'),
(37, 'ssss', 'sw@gmail.com', 'Employee', 'suvvu', '2025-09-24', '333333333333333', 'India', NULL, 'active', NULL, '[]');

-- --------------------------------------------------------

--
-- Table structure for table `work_logs`
--

CREATE TABLE `work_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `log_date` date NOT NULL,
  `clock_in` datetime DEFAULT NULL,
  `clock_out` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `work_logs`
--

INSERT INTO `work_logs` (`id`, `user_id`, `log_date`, `clock_in`, `clock_out`) VALUES
(1, 10, '2025-09-25', '2025-09-25 11:51:17', '2025-09-25 11:51:40'),
(2, 12, '2025-09-25', '2025-09-25 11:52:38', NULL),
(3, 4, '2025-09-25', '2025-09-25 11:53:18', NULL),
(4, 11, '2025-09-25', '2025-09-25 14:22:45', NULL),
(5, 10, '2025-09-26', '2025-09-26 09:33:51', '2025-09-26 18:29:49'),
(6, 4, '2025-09-26', '2025-09-26 09:34:39', NULL),
(7, 10, '2025-09-27', '2025-09-27 11:24:53', NULL),
(8, 4, '2025-09-27', '2025-09-27 12:03:41', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `department_employees`
--
ALTER TABLE `department_employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leave_requests`
--
ALTER TABLE `leave_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `payroll`
--
ALTER TABLE `payroll`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_assignments`
--
ALTER TABLE `project_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `work_logs`
--
ALTER TABLE `work_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `department_employees`
--
ALTER TABLE `department_employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `leave_requests`
--
ALTER TABLE `leave_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payroll`
--
ALTER TABLE `payroll`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `project_assignments`
--
ALTER TABLE `project_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `work_logs`
--
ALTER TABLE `work_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `department_employees`
--
ALTER TABLE `department_employees`
  ADD CONSTRAINT `department_employees_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `department_employees_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `payroll`
--
ALTER TABLE `payroll`
  ADD CONSTRAINT `payroll_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `project_assignments`
--
ALTER TABLE `project_assignments`
  ADD CONSTRAINT `project_assignments_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_assignments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `work_logs`
--
ALTER TABLE `work_logs`
  ADD CONSTRAINT `work_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
