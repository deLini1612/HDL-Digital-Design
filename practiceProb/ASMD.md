# ASMD (Algorithmic State Machine Datapath)

Coi ASMD nhu 1 phuong phap de chuyen doi luu do thuat toan thanh phan cung (FSMD) dua tren ASMD

# Dinh nghia ASM
ASM la do thi, co cac khai niem node, canh, khoi

## Node
Gom 3 loai node:
1. Node trang thai: co nhan la ten
2. Dieu kien: kiem tra gia tri cua (cac) bien
3. Node dau ra: gan gia tri cho dau ra

## Khoi
Khoi la 1 nhom cac node:
- Co **DUY NHAT 01 node trang thai**
- Co the co 0, 1 hoac nhieu node dieu kien va not dau ra

## Canh
- Noi giua cac node
- Co the danh nhan bang cac thao tac tren bien du lieu
- Cac canh di vao 1 khoi **PHAI** di vao node trang thai

# ASM bo nhan noi tiep (vo Duong)
## Ky hieu trong ASM (vo Duong)

Y nghia cua ASMD:
- Khi co suon dong ho thi se chuyen block
- Khi dang o trong 1 block thi se kiem tra dieu kien va tinh toan (the hien = cac annotation [danh nhan] tren cac canh)

=> ASMD la 1 cach de mo ta hoat dong cua he thong gom ca phan FSM dieu khien va datapath

# Thiet ke ASMD thang may
Check file elevator.v
