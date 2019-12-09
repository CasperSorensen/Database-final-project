--EXPORT FOR TUser into Users collection
SELECT cFirstName + ' ' + cSurname as 'name', cAddress AS 'address', cCityName AS 'city', cPhoneNo AS 'phoneNo', cEmail AS 'email', nTotalAmount AS 'totalAmount'
FROM TUser AS Users
	INNER JOIN TCity AS City ON Users.nCityId = City.nCityId
FOR JSON PATH;

--EXPORT FOR TProduct into Products collection
SELECT cName AS 'productName', cDescription AS 'description', nUnitPrice AS 'unitPrice', nStock AS 'stock', nAvgRating AS 'avgRating'
FROM TProduct
FOR JSON PATH;

--EXPORT FOR TRating into Ratings collection
SELECT TProduct.cName AS 'productName', TUser.cFirstName + ' ' + TUser.cSurname AS 'userName', nRating AS 'rating', cComment AS 'comment'
FROM TRating 
	INNER JOIN TProduct ON TRating.nProductId = TProduct.nProductId
	INNER JOIN TUser ON TRating.nUserId = TUser.nUserId
FOR JSON PATH, INCLUDE_NULL_VALUES 