-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 12, 2023 at 12:32 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cakeorder`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer` (IN `_cust_id` INT)   BEGIN
set @tbalance = 0;
set @amount = 0;

CREATE TEMPORARY TABLE tb SELECT payment.paid_date, payment.customer_id,
sum(amount), @tbalance:= @tbalance+amount FROM payment WHERE payment.customer_id
     = _cust_id ORDER BY payment.paid_date ASC;
     
     SELECT * from tb
     
          UNION 
     
     SELECT '', '', SUM(amount), SUM(evc), @tbalance FROM tb;
     
     
    


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getcu` (IN `_customer_id` INT)   BEGIN
    SELECT payment_id,  paid_date,amount
    FROM payment JOIN customers USING(customer_id)
    WHERE customer_id = _customer_id;

    SELECT  SUM(amount) AS subtotal
    FROM payment  JOIN customers USING(customer_id)
    WHERE customer_id = _customer_id;
    
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loan_register` (IN `_customer_id` INT, IN `_item` VARCHAR(50), IN `_type` INT, IN `_total_price` INT, IN `_loan_type` VARCHAR(50))   BEGIN
  INSERT INTO loan (customer_id, item,scheme_type_id, total_price,loan_type) VALUES (_customer_id, _item, _type, _total_price, _loan_type);

	 SELECT "success" as Massage;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pro` (IN `_amount` DECIMAL, IN `_type` INT, OUT `_result` INT)   BEGIN

-- INSERT INTO loan (customer_id, amount) VALUES (_customer_id, _amount);

 -- SELECT amount from loan WHERE amount = _amount / _type;
 
 SET   _result = _amount /_type;
-- SELECT amount as amount;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `search` (IN `_customer_id` INT)   BEGIN 

select p.payment_id, c.fullname,c.email, SUM(p.amount) from
payment p join customers c on p.customer_id= c.customer_id where c.customer_id=_customer_id
group by p.payment_id

UNION

     SELECT '', '', '', SUM(amount) FROM payment;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `account_id` int(11) NOT NULL,
  `number` bigint(20) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `balance` decimal(9,2) NOT NULL DEFAULT 0.00,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`account_id`, `number`, `bank_name`, `balance`, `create_date`) VALUES
(1, 900, 'mybank', '0.00', '2023-03-27 11:02:02');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `number` int(11) NOT NULL,
  `bailnumber` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `fullname`, `email`, `number`, `bailnumber`, `date`) VALUES
(1, 'anwar isak', 'saadaqisak@gmail.com', 2526981, 2526160, '2023-04-04 11:55:46'),
(2, 'sadaq isak', 'anwarisack@gmail.com', 61678788, 61678788, '2023-04-04 12:18:32'),
(3, 'abdirahman', 'najiib@gmail.com', 12121212, 1212121, '2023-04-04 12:18:43'),
(4, 'najiib maxamed', 'ismaacil@gmail.com', 901920, 1290129012, '2023-04-04 12:18:59'),
(5, 'l', 'SDF', 234, 232, '2023-04-04 12:20:58'),
(6, 'jaamac', 'jaamac@gmail.com', 90990, 90909, '2023-04-04 16:20:18');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `loan_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `item` varchar(50) NOT NULL,
  `scheme_type_id` int(11) NOT NULL,
  `total_price` decimal(9,2) DEFAULT NULL,
  `loan_type` varchar(50) NOT NULL,
  `isue_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`loan_id`, `customer_id`, `item`, `scheme_type_id`, `total_price`, `loan_type`, `isue_date`) VALUES
(1, 1, 'ani', 1, '91.00', '', '2023-04-03 04:59:27'),
(2, 4, 'llll', 1, '90.00', 'person', '2023-04-03 05:00:03'),
(3, 1, 'ani', 1, '91.00', '', '2023-04-03 05:00:41'),
(4, 1, 'ani', 1, '100.00', 'person', '2023-04-03 06:01:53'),
(5, 5, 'Mackbook', 1, '2000.00', 'company', '2023-04-03 05:27:27'),
(6, 2, 'ww', 1, '222.00', 'ee', '2023-04-03 08:47:29');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `account_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `paid_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `customer_id`, `amount`, `account_id`, `payment_method_id`, `paid_date`) VALUES
(1, 1, '100.00', 1, 1, '2023-04-02 07:04:07'),
(2, 2, '200.00', 1, 2, '2023-04-09 11:44:29'),
(3, 3, '100.00', 1, 1, '2023-04-05 13:19:42'),
(4, 4, '100.00', 1, 2, '2023-04-09 11:44:37'),
(7, 1, '300.00', 1, 1, '2023-04-02 07:04:07'),
(8, 1, '40.00', 1, 1, '2023-04-02 07:04:07');

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `payment_method_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`payment_method_id`, `name`) VALUES
(1, 'evc'),
(2, 'jeep');

-- --------------------------------------------------------

--
-- Table structure for table `scheme_type`
--

CREATE TABLE `scheme_type` (
  `scheme_type_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `number` int(11) NOT NULL,
  `interest_rate` float(9,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `scheme_type`
--

INSERT INTO `scheme_type` (`scheme_type_id`, `name`, `number`, `interest_rate`) VALUES
(1, 'monthly', 30, 0.10),
(2, 'yearly', 12, 0.20);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `usertype` varchar(30) NOT NULL,
  `cs_status` int(11) DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `email`, `password`, `usertype`, `cs_status`, `date`) VALUES
(41, 'anwar', 'anwar', '1212', '', 99, '2023-04-04 06:24:54'),
(42, 'moha', 'moha', '1212', 'admin', 99, '2023-04-04 06:24:54'),
(46, 'anwarisak', 'anwar', '1212', 'user', 99, '2023-04-04 06:24:54'),
(49, 'ismaaciil', 'ismaaciil', '1212', 'admin', 99, '2023-04-04 06:24:54'),
(50, 'ismaaciil', 'ismaaciil', '', 'admin', 99, '2023-04-04 06:24:54'),
(60, 'ghghgh', 'hghgh', '76676', 'gtytyt', 99, '2023-04-04 06:24:54'),
(68, '', '', '', 'admin', 99, '2023-04-04 11:04:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`account_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `scheme_type_id` (`scheme_type_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `payment_method_id` (`payment_method_id`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`payment_method_id`);

--
-- Indexes for table `scheme_type`
--
ALTER TABLE `scheme_type`
  ADD PRIMARY KEY (`scheme_type_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `scheme_type`
--
ALTER TABLE `scheme_type`
  MODIFY `scheme_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`scheme_type_id`) REFERENCES `scheme_type` (`scheme_type_id`),
  ADD CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  ADD CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_method_id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `update_my_column` ON SCHEDULE EVERY 2 MINUTE STARTS '2023-04-04 11:34:54' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE user SET cs_status = 99 WHERE user_id = user_id$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
