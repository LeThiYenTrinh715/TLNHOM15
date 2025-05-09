-- Tạo Database
CREATE DATABASE QLLD;
GO


-- Tạo bảng KHOA
CREATE TABLE KHOA (
    MAKHOA VARCHAR(10) PRIMARY KEY,
    TENKHOA NVARCHAR(100),
    DTKHOA VARCHAR(15)
);

-- Tạo bảng GIAOVIEN
CREATE TABLE GIAOVIEN (
    MAGV VARCHAR(10) PRIMARY KEY,
    HOTEN NVARCHAR(100),
    DTGV VARCHAR(15),
    MAKHOA VARCHAR(10),
    FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);

-- Tạo bảng MONHOC
CREATE TABLE MONHOC (
    MAMH VARCHAR(10) PRIMARY KEY,
    TENMH NVARCHAR(100)
);

-- Tạo bảng LOP
CREATE TABLE LOP (
    MALOP VARCHAR(10) PRIMARY KEY,
    TENLOP NVARCHAR(100),
    SISO INT,
    MAKHOA VARCHAR(10),
    FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);

-- Tạo bảng PHONGHOC
CREATE TABLE PHONGHOC (
    PHONG VARCHAR(10) PRIMARY KEY,
    CHUCNANG NVARCHAR(100)
);

-- Tạo bảng LICHDAY
CREATE TABLE LICHDAY (
    MAGV VARCHAR(10),
    MALOP VARCHAR(10),
    MAMH VARCHAR(10),
    PHONG VARCHAR(10),
    NGAYDAY DATE,
    TUTIET INT,
    DENTIET INT,
    BAIDAY NVARCHAR(100),
    GHICHU NVARCHAR(255),
    LYTHUYET BIT,
    PRIMARY KEY (MAGV, MALOP, MAMH, PHONG, NGAYDAY, TUTIET),
    FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV),
    FOREIGN KEY (MALOP) REFERENCES LOP(MALOP),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
    FOREIGN KEY (PHONG) REFERENCES PHONGHOC(PHONG)
);
--Tạo database trên SSMS
--Bảng KHOA
INSERT INTO KHOA VALUES
('KH01', N'Công nghệ thông tin', '0281234567'),
('KH02', N'Kinh tế', '0281234568'),
('KH03', N'Điện - Điện tử', '0281234569'),
('KH04', N'Cơ khí', '0281234570'),
('KH05', N'Ngoại ngữ', '0281234571')

--Bảng GIAOVIEN
INSERT INTO GIAOVIEN VALUES
('GV01', N'Nguyễn Văn A', '0911111111', 'KH01'),
('GV02', N'Trần Thị B', '0911111112', 'KH01'),
('GV03', N'Lê Văn C', '0911111113', 'KH02'),
('GV04', N'Phạm Thị D', '0911111114', 'KH03'),
('GV05', N'Hoàng Văn E', '0911111115', 'KH04')

--Bảng MONHOC
INSERT INTO MONHOC VALUES
('MH01', N'Cơ sở dữ liệu'),
('MH02', N'Nguyên lý kế toán'),
('MH03', N'Mạng máy tính'),
('MH04', N'Điện tử cơ bản'),
('MH05', N'Vẽ kỹ thuật')

--Bảng PHONGHOC
INSERT INTO PHONGHOC VALUES
('P101', N'Phòng lý thuyết'),
('P102', N'Phòng máy tính'),
('P103', N'Phòng thực hành điện'),
('P104', N'Phòng đa năng'),
('P105', N'Phòng vẽ cơ khí')

--Bảng LOP
INSERT INTO LOP VALUES
('L01', N'DHTH01', 40, 'KH01'),
('L02', N'KT01', 45, 'KH02'),
('L03', N'DT01', 50, 'KH03'),
('L04', N'CK01', 38, 'KH04'),
('L05', N'NN01', 42, 'KH05')

--Bảng LICHDAY
INSERT INTO LICHDAY VALUES
('GV01', 'L01', 'MH01', 'P102', '2025-05-05', 1, 3, N'Giới thiệu CSDL', N'Không có ghi chú', 1),
('GV02', 'L01', 'MH03', 'P101', '2025-05-06', 4, 6, N'Tổng quan mạng máy tính', NULL, 1),
('GV03', 'L02', 'MH02', 'P104', '2025-05-07', 1, 3, N'Nguyên lý Kế toán căn bản', N'Ghi chú: mang máy tính', 1),
('GV04', 'L03', 'MH04', 'P103', '2025-05-08', 7, 9, N'Điện trở và tụ điện', NULL, 2),
('GV05', 'L04', 'MH05', 'P105', '2025-05-09', 10, 12, N'Vẽ kỹ thuật cơ bản', NULL, 2)

GO

--TỰ CHO CÂU HỎI VÀ TRẢ LỜI
--DẠNG LIỆT KÊ:
--Q1: Liệt kê họ tên giáo viên, tên môn học, tên lớp và ngày dạy.
SELECT GV.HOTEN, MH.TENMH, L.TENLOP, LD.NGAYDAY
FROM LICHDAY LD
JOIN GIAOVIEN GV ON LD.MAGV = GV.MAGV
JOIN MONHOC MH ON LD.MAMH = MH.MAMH
JOIN LOP L ON LD.MALOP = L.MALOP

GO 
--Q2:Cho biết số môn học mà mỗi giáo viên đã dạy 

SELECT GV.MAGV, GV.HOTEN, COUNT(DISTINCT MH.MAMH) AS SoMonDay 
FROM GIAOVIEN GV 
JOIN LICHDAY LD ON GV.MAGV = LD.MAGV 
JOIN MONHOC MH ON LD.MAMH = MH.MAMH 
GROUP BY GV.MAGV, GV.HOTEN;

GO

--DẠNG UPDATE:
--Q1: Cập nhật số điện thoại của khoa Thương mại điện tử có mã 'TMDT' thành '0919105107'
update KHOA
set DTKHOA = '0919105107'
where MAKHOA = 'KH01'

GO

--Q2: Cập nhật số điện thoại của giáo viên có mã là GV01.
UPDATE GIAOVIEN
SET DTGV = '0987654321'
WHERE MAGV = 'GV01'

GO

--DẠNG DELETE:
--Q1: Xóa tất cả các lịch dạy của giáo viên có tên 'Phạm Thị D'.
DELETE LICHDAY 
WHERE MAGV IN (
SELECT MAGV 
FROM GIAOVIEN
WHERE HOTEN = 'Phạm Thị D')

GO

--Q2: Xoá lịch dạy tiết 3,4 của giáo viên có mã ‘GV01’ vào ngày 10/5/2025:
DELETE FROM LICHDAY
WHERE MAGV = 'GV01' AND NGAYDAY = '2025-05-05' AND TUTIET = 1 AND DENTIET = 3

GO

--DẠNG GROUP BY:
--Q1: Đếm số buổi dạy của từng giáo viên
SELECT MAGV, COUNT(*) AS SoBuoiDay
FROM LICHDAY
GROUP BY MAGV

GO 

--Q2: Thống kê số lượng giáo viên thuộc mỗi khoa. Hiển thị mã khoa và số lượng giáo viên.
SELECT k.MAKHOA, k.TENKHOA, COUNT(g.MAGV) AS SoLuongGiaoVien 
FROM KHOA k 
LEFT JOIN GIAOVIEN g ON k.MAKHOA = g.MAKHOA 
GROUP BY k.MAKHOA, k.TENKHOA

GO

--DẠNG SUB QUERY: 
--Q1: Liệt kê các lớp có sĩ số lớn hơn sĩ số trung bình của tất cả các lớp.
SELECT * FROM LOP
WHERE SISO > (
    SELECT AVG(SISO) FROM LOP)

GO

--Q2: Liệt kê tên của các lớp thuộc khoa 'Công nghệ thông tin'.
SELECT TENLOP
FROM LOP
WHERE MAKHOA = (SELECT MAKHOA 
      FROM KHOA WHERE TENKHOA = N'Công nghệ thông tin')

GO

--DẠNG BẤT KÌ:
--Q1: Cập nhật lại tên môn học có mã môn là 'MH01' thành 'Lập trình Python nâng cao'.
UPDATE MONHOC
SET TENMH = 'Lập trình Python nâng cao' 
WHERE MAMH = 'MH01'

GO

--Q2: Đếm số buổi dạy của từng giáo viên theo tháng
SELECT MAGV, MONTH(NGAYDAY) AS Thang, COUNT(*) AS SoBuoiDay
FROM LICHDAY
GROUP BY MAGV, MONTH(NGAYDAY)
GO

BACKUP DATABASE qlld
TO DISK = 'D:\a\Cơ sở dữ liệu\QLLD.bak'
WITH INIT, FORMAT;