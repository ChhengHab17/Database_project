-- register
DELIMITER //

CREATE PROCEDURE register_user (
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(50),
    IN p_phone_num VARCHAR(15),
    IN p_password VARCHAR(255),
    IN p_user_type VARCHAR(20)
)
BEGIN
    DECLARE user_exists INT DEFAULT 0;

    -- Check if username or email already exists
    SELECT COUNT(*) INTO user_exists
    FROM User
    WHERE username = p_username OR email = p_email;

    IF user_exists > 0 THEN
        SELECT 'Username or email already exists.' AS message;
    ELSE
        -- Hash the password and insert the user
        INSERT INTO User (username, email, phone_num, password, user_type)
        VALUES (p_username, p_email, p_phone_num, SHA2(p_password, 256), p_user_type);

        SELECT 'User registered successfully' AS message;
    END IF;
END //

DELIMITER ;
CALL register_user('john_doe', 'john@example.com', '1234567890', 'secret123', 'Admin');
CALL register_user('jame', 'jhn@example.com', '1234567890', 'secret123', 'Worker');
CALL register_user('johndoe', 'jon@example.com', '1234567890', 'secret123', 'Student');




-- update user name
DELIMITER //

CREATE PROCEDURE update_username (
    IN p_user_id INT,
    IN p_new_username VARCHAR(50)
)
BEGIN
    DECLARE username_exists INT DEFAULT 0;

    -- Check if new username already exists
    SELECT COUNT(*) INTO username_exists
    FROM user
    WHERE username = p_new_username;

    IF username_exists > 0 THEN
        SELECT 'Username already taken. Please choose a different one.' AS message;
    ELSE
        UPDATE user
        SET username = p_new_username
        WHERE user_id = p_user_id;

        IF ROW_COUNT() = 0 THEN
            SELECT 'User not found or username is unchanged.' AS message;
        ELSE
            SELECT 'Username updated successfully!' AS message;
        END IF;
    END IF;
END //

DELIMITER ;
CALL update_username(3, 'michael_updated');

-- update user email
DELIMITER //

CREATE PROCEDURE update_user_email (
    IN p_user_id INT,
    IN p_new_email VARCHAR(50)
)
BEGIN
    DECLARE email_exists INT DEFAULT 0;

    -- Check if email is already used by someone else
    SELECT COUNT(*) INTO email_exists
    FROM user
    WHERE email = p_new_email AND user_id != p_user_id;

    IF email_exists > 0 THEN
        SELECT 'Email is already in use by another user.' AS message;
    ELSE
        UPDATE user
        SET email = p_new_email
        WHERE user_id = p_user_id;

        IF ROW_COUNT() = 0 THEN
            SELECT 'User not found or email is unchanged.' AS message;
        ELSE
            SELECT 'Email updated successfully!' AS message;
        END IF;
    END IF;
END //

DELIMITER ;
CALL update_user_email(5, 'newemail@example.com');

-- update phone number
DELIMITER //

CREATE PROCEDURE update_user_phone (
    IN p_user_id INT,
    IN p_new_phone VARCHAR(15)
)
BEGIN
    DECLARE phone_exists INT DEFAULT 0;

    -- Check if the phone number is already taken by another user
    SELECT COUNT(*) INTO phone_exists
    FROM user
    WHERE phone_num = p_new_phone AND user_id != p_user_id;

    IF phone_exists > 0 THEN
        SELECT 'Phone number is already in use by another user.' AS message;
    ELSE
        UPDATE user
        SET phone_num = p_new_phone
        WHERE user_id = p_user_id;

        IF ROW_COUNT() = 0 THEN
            SELECT 'User not found or phone number is unchanged.' AS message;
        ELSE
            SELECT 'Phone number updated successfully!' AS message;
        END IF;
    END IF;
END //

DELIMITER ;
CALL update_user_phone(7, '777888999');

-- update haash password
DELIMITER //

CREATE PROCEDURE update_user_password (
    IN p_user_id INT,
    IN p_new_password VARCHAR(255)
)
BEGIN
    UPDATE user
    SET password = SHA2(p_new_password, 256)
    WHERE user_id = p_user_id;

    IF ROW_COUNT() = 0 THEN
        SELECT 'User not found or password unchanged.' AS message;
    ELSE
        SELECT 'Password updated and hashed successfully!' AS message;
    END IF;
END //

DELIMITER ;
CALL update_user_password(13, 'mySecureNewPass13');
-- updaate user type
DELIMITER //

CREATE PROCEDURE update_user_type (
    IN p_username VARCHAR(50),
    IN p_new_user_type VARCHAR(50)
)
BEGIN
    DECLARE user_found INT DEFAULT 0;

    -- Check if the user exists
    SELECT COUNT(*) INTO user_found
    FROM User
    WHERE username = p_username;

    IF user_found = 0 THEN
        SELECT 'User not found.' AS message;
    ELSE
        -- Update user_type
        UPDATE User
        SET user_type = p_new_user_type
        WHERE username = p_username;

        SELECT 'User type updated successfully.' AS message;
    END IF;
END //

DELIMITER ;
call update_user_type ('jame', 'Student');
-- view
CREATE VIEW user_profile_summary AS
SELECT 
    u.user_id,
    u.username,
    u.email,
    u.phone_num,
    b.weekly_budget,
    b.monthly_budget,
    i.amount AS income_amount,
    i.currency AS income_currency,
    (SELECT SUM(e.amount) 
     FROM Expense e 
     WHERE e.user_id = u.user_id) AS total_expense
FROM user u
LEFT JOIN Budget b ON u.user_id = b.user_id
LEFT JOIN Income i ON u.user_id = i.user_id;
select * from user_profile_summary;
