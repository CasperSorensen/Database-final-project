CREATE TABLE TAuditCreditCard
(
  nTAuditCreditCardId INT IDENTITY(1,1) NOT NULL,
  before_nCreditCardId INT,
  before_nUserId INT,
  before_cIBANCode VARCHAR(34),
  before_dExpDate VARCHAR(4),
  before_nCcv INT,
  before_cCardholderName VARCHAR(40),
  before_nAmountSpent DECIMAL(2),
  after_nCreditCardId INT,
  after_nUserId INT,
  after_cIBANCode VARCHAR(34),
  after_dExpDate VARCHAR(4),
  after_nCcv INT,
  after_cCardholderName VARCHAR(40),
  after_nAmountSpent DECIMAL(2),
  cStatementType VARCHAR(10),
  dtExecutedAt DATETIME,
  nDBMSId INT,
  cDBMSName NVARCHAR(128),
  cHostId CHAR(8),
  cHostName NVARCHAR(128)
);
