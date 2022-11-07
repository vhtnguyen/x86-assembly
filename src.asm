;Nhap xuat mang 1 chieu
%include "io.inc"
extern _printf
extern _scanf
extern _getch

section .data
    tb1 db "Nhap n: ",0
    tb2 db "a[%d]: ",0
    fmt1 db "%d",0
    fmt2 db "%d ",0
    tb3 db "Mang vua nhap la: ",0
    tb4 db 10,"===== MENU =====",10,"1. Nhap mang",10,"2. Xuat mang",10,"3. Liet ke cac so nguyen to",10,"4. Liet ke cac so hoan thien",10,"5. Dem so luong so chinh phuong",10,"6. Tinh tong cac so doi xung",10,"7. Tim gia tri lon nhat",10,"8. Sap xep mang tang dan",10,"9. Thoat",10,"=====================",0
    tb5 db 10,"Nhap lua chon: ",0
    tb6 db 10, "danh sach so nguyen to trong mang: ",0
    tb7 db 10, "Danh sach so hoan thien trong mang: ",0
    tb8 db 10, "So luong so chinh phuong trong mang: ",0
    tb9 db 10, "Tong cac so doi xung trong mang: ",0
    tb10 db 10, "So lon nhat trong mang: ",0
    tb11 db 10, "Mang sau khi sap xep tang dan: ",0
    tb12 db 10, "Ket thuc chuong trinh!",0
    
section .bss
    arr resd 100
    n resd 1
    cmd resd 1
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    ;xuat tb1
    
    
    call _NhapMang
    jmp _begin.Menu
   
    
 global _NhapMang
_NhapMang:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax
    
    ;xuat tb nhap n
    push dword tb1
    call _printf
    add esp,4
    
    ;Nhap n
    push dword n
    push dword fmt1
    call _scanf
    add esp,8
     ;Khoi tao vong lap
    mov ebx, arr ; load dia chi mang vao ebx (bat buoc)
    mov esi, 0; bien duyet mang (bat buoc)
    
Nhap:
    ;xuat tb nhap a[i]
    push esi
    push dword tb2
    call _printf
    add esp,8
    
    ;Nhap a[i]
    push ebx
    push dword fmt1
    call _scanf
    add esp,8
    
    ;Tang dia chi mang
    add ebx,4
    ;Tang chi so i
    inc esi
    ;Kiem tra i<n thi lap
    cmp esi, dword [n]
    jl Nhap
    
    ;cuoi thu tuc
    ;Restore thanh ghi neu co
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret  
    
;***********************************************************************************************    
   ;Dau thu tuc
global _XuatMang
_XuatMang:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax
    
    
    ;Khoi tao vong lap
    mov ebx, arr ; Load dia chi mang vao ebx
    mov esi, 0; khoi tao i = 0
     ;Xuat mang
    push dword tb3
    call _printf
    add esp, 4
 
    
;Than thu tuc
   Xuat:

    push dword [ebx]
    push dword fmt2
    call _printf
    add esp,8
    
    ;Tang dia chi mang
    add ebx, 4
    ;Tang i
    inc esi
    ;Kiem tra i < n thi lap
    cmp esi, dword [n]
    jl Xuat
    
    ;Restore thanh ghi neu co
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret

;********************************************************************************

global _SoNT
_SoNT:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax 
    
      ;danh sach so nguyen to trong mang la    
    push dword tb6
    call _printf
    add esp, 4
    ;Khoi tao vong lap
    mov ebx, arr ; Load dia chi mang vao ebx
    mov esi, 0; khoi tao i = 0
XuatNguyenTo:
    push dword [ebx]
    call _KiemTraSoNgTo
    add esp, 4

    cmp eax, 1
    je NT.XuatPt    
    jmp NT.tangChiSo
NT.XuatPt:
    push dword [ebx]
    push dword fmt2
    call _printf
    add esp,8
    
NT.tangChiSo: 
    ;Tang dia chi mang
    add ebx, 4
    ;Tang i
    inc esi
    ;Kiem tra i < n thi lap
    cmp esi, dword [n]
    jl XuatNguyenTo
  
     ;Restore thanh ghi neu co
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret
    
    
    
    
;Dau thu tuc
global _KiemTraSoNgTo
_KiemTraSoNgTo:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax
    
    ;Lay tham so thu nhat
    ;mov ebx,dword [ebp + 8]; lay n
    
;Than thu tuc
    ;dem = 0
    ;i = 1
    mov ebx, 0
    mov ecx, 1
    
_KiemTraSoNgTo.Lap:
    xor edx, edx
    ;Tinh phan du = a[i] % j
    mov eax, dword [ebp + 8]
    div ecx
    
    ;neu du = 0 thi Tang chi so i
    cmp edx, 0
    je _KiemTraSoNgTo.TangI
    
    ;TangJ
    jmp _KiemTraSoNgTo.TangJ
    
_KiemTraSoNgTo.TangI:
    inc ebx
_KiemTraSoNgTo.TangJ:
    inc ecx
    
    ;kiem tra i <= a[i] thi quay lai vong lap
    cmp ecx, dword [ebp + 8]
    jle _KiemTraSoNgTo.Lap
;Neu I = 2, thi tra ve 1 nguoc lai thi 0
    cmp ebx, 2
    je _KiemTraSoNgTo.return1
    mov eax,0
    jmp _KiemTraSoNgTo.Thoat
_KiemTraSoNgTo.return1:
    mov eax,1
;Cuoi thu tuc
_KiemTraSoNgTo.Thoat:
    
    ;Restore thanh ghi neu co
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret


;********************************************************************************
global _SoHT
_SoHT:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax
;danh sach so hoan thien trong mang la
    push dword tb7
    call _printf
    add esp, 4
    
    
    ;Khoi tao vong lap
    mov ebx, arr ; Load dia chi mang vao ebx
    mov esi, 0; khoi tao i = 0
XuatHoanThien:
    push dword [ebx]
    call _KiemTraSoHoanThien
    add esp, 4

    cmp eax, 1
    je HT.XuatPt    
    jmp HT.tangChiSo
HT.XuatPt:
    push dword [ebx]
    push dword fmt2
    call _printf
    add esp,8
    
HT.tangChiSo: 
    ;Tang dia chi mang
    add ebx, 4
    ;Tang i
    inc esi
    ;Kiem tra i < n thi lap
    cmp esi, dword [n]
    jl XuatHoanThien
  
    ;Restore thanh ghi neu co
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret
    
    
    
    
    
;Dau thu tuc
global _KiemTraSoHoanThien
_KiemTraSoHoanThien:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax
    
    ;Lay tham so thu nhat
    ;mov ebx,dword [ebp + 8]; lay n
    
;Than thu tuc
    ;sum = 0
    ;i = 1
    mov ebx, 0
    mov ecx, 1
   
_KiemTraSoHT.Lap:
    xor edx, edx
    ;Tinh phan du = a[i] % j
    mov eax, dword [ebp + 8]
    div ecx
    
    ;neu du = 0 thi cong a[i] vao sum
    cmp edx, 0
    je _KiemTraSoHT.TangSum
    ;TangJ
    jmp _KiemTraSoHT.TangJ
_KiemTraSoHT.TangSum:
  ;tang sum
  add ebx,ecx


_KiemTraSoHT.TangJ:
    inc ecx
    
    ;kiem tra i < a[i] thi quay lai vong lap
    cmp ecx, dword [ebp + 8]
    jl _KiemTraSoHT.Lap
;Neu sum = a[i], thi tra ve 1 nguoc lai thi 0
    cmp ebx, dword [ebp + 8]
    je _KiemTraSoHT.return1
    mov eax,0
    jmp _KiemTraSoHT.Thoat
_KiemTraSoHT.return1:
    mov eax,1
;Cuoi thu tuc
_KiemTraSoHT.Thoat:
    
    ;Restore thanh ghi neu co
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret

;********************************************************************************
global _CP
_CP:

    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax

;danh sach so cp trong mang la
    

    push dword tb8
    call _printf
    add esp, 4
    
    
    ;Khoi tao vong lap
    mov ebx, arr ; Load dia chi mang vao ebx
    mov esi, 0; khoi tao i = 0
    mov edi,0;
XuatCP:
    push dword [ebx]
    call _KiemTraSoCP
    add esp, 4

    add edi, eax   
    jmp CP.tangChiSo

CP.tangChiSo: 
    ;Tang dia chi mang
    add ebx, 4
    ;Tang i
    inc esi
    ;Kiem tra i < n thi lap
    cmp esi, dword [n]
    jl XuatCP
  
    push dword edi
    push dword fmt2
    call _printf
    add esp,8
  
     ;Restore thanh ghi neu co
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret
    
    
    
    
;Dau thu tuc
global _KiemTraSoCP
_KiemTraSoCP:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax
    
    
;Than thu tuc
    ;sum = 0
    ;i = 1
    mov ebx, 0
    mov ecx, 1
   
_KiemTraSoCP.Lap:

    mov ebx, dword [ebp + 8]
    mov eax,ecx
    mul eax
    
   
    cmp eax, ebx
    je _KiemTraSoCP.return1
    ;TangJ
    jmp _KiemTraSoCP.TangJ



_KiemTraSoCP.TangJ:
    inc ecx
    
    ;kiem tra i*i < a[i] thi quay lai vong lap
    cmp eax, dword [ebp + 8]
    jl _KiemTraSoCP.Lap
    mov eax,0
    jmp _KiemTraSoCP.Thoat
_KiemTraSoCP.return1:
    mov eax,1
;Cuoi thu tuc
_KiemTraSoCP.Thoat:
    
    ;Restore thanh ghi neu co
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret


;********************************************************************************
global _SoDX
_SoDX:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax
    
;danh sach so ds trong mang la


    push dword tb9
    call _printf
    add esp, 4
    xor ecx,ecx
    
    ;Khoi tao vong lap
    mov ebx, arr ; Load dia chi mang vao ebx
    mov esi, 0; khoi tao i = 0
XuatDX:
    push dword [ebx]
    call _KiemTraSoDX
    add esp, 4

    cmp eax, 1
    je DX.tangSum   
    jmp DX.tangChiSo
DX.tangSum:
    add ecx,dword [ebx]
    
DX.tangChiSo: 
    ;Tang dia chi mang
    add ebx, 4
    ;Tang i
    inc esi
    ;Kiem tra i < n thi lap
    cmp esi, dword [n]
    jl XuatDX
    
    ;xuat sum
    
    push ecx
    push fmt1
    call _printf
    add esp,8
    
  
    ;Restore thanh ghi neu co
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret
    
    
    
    
    
;Dau thu tuc
global _KiemTraSoDX
_KiemTraSoDX:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    push ecx
    xor eax,eax
    
    
;Than thu tuc
    ;sum = 0
    ;i = a[]
    xor ebx, ebx
    mov ecx, dword [ebp + 8]
    
   ;for(temp=num;num!=0;num=num/10){
        ; r=num%10;
         ;sum=sum*10+r;
    ;}
_KiemTraSoDX.Lap:
    xor edx, edx
    
    mov eax,ecx
    mov ecx,10
    div ecx
    mov ecx,eax ;num=num/10
    mov edi,edx;edi=num%10
    mov eax,ebx
    mov ebx,10
    mul ebx ; sum=sum*10
    add eax,edi
    mov ebx,eax
    ;sum=sum*10+r
  
  ;giam i
    cmp ecx,0
    jne _KiemTraSoDX.Lap
    cmp ebx,dword [ebp + 8]
    je _KiemTraSoDX.return1
    mov eax,0
    jmp _KiemTraSoDX.Thoat
    
_KiemTraSoDX.return1:
    mov eax,1
;Cuoi thu tuc
_KiemTraSoDX.Thoat:
    
    ;Restore thanh ghi neu co
    pop ecx
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret

;********************************************************************************
;Dau thu tuc
global _TimSoLonNhat
_TimSoLonNhat:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax

    push dword tb10
    call _printf
    add esp, 4
    call _TimMax
    
    push eax
    push dword fmt2
    call _printf
    add esp,8
    
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret
   
    
;Dau thu tuc
global _TimMax
_TimMax:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax
    
    ;than thu tuc
    
    ;Khoi tao vong lap
    mov ebx, arr ; Load dia chi mang vao ebx
    mov eax,dword [ebx]
    
   
    mov esi, 1; khoi tao i = 1
    ;neu chi co 1 phan tu
    cmp esi,[n]
    jge _TimMax.KetThuc
    
     ;neu co nhieu hon 1 phan tu
    add ebx, 4 ; tang chi so qua phan tu 2
_TimMax.Loop:
    cmp eax,dword [ebx]
    jge _TimMax.TangI
    
    mov eax,dword[ebx]
    
    _TimMax.TangI:
    ;Tang dia chi mang
    add ebx, 4
    ;Tang i
    inc esi
    ;Kiem tra i < n thi lap
    cmp esi, dword [n]
    jl _TimMax.Loop
    
    ;cuoi thu tuc
    
_TimMax.KetThuc:
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret

;********************************************************************************
global _sapXep
_sapXep:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax     


    push dword tb11
    call _printf
    add esp, 4
    
    
     mov ecx,[n]
 _sort.outerloop:   
    ;Khoi tao vong lap
    mov ebx, arr ; Load dia chi mang vao ebx
    mov esi, 1; khoi tao i = 1
   

 _sort.innerloop:     
    push dword [ebx]
    call _sort
    add esp, 4
    jmp SX.tangChiSo
    


    
SX.tangChiSo: 
    ;Tang dia chi mang
    add ebx, 4
    ;Tang i
    inc esi
    ;Kiem tra i < n thi lap
    cmp esi, ecx
    jl _sort.innerloop
    
    loop _sort.outerloop
    
    ;Khoi tao vong lap
    mov ebx, arr ; Load dia chi mang vao ebx
    mov esi, 0; khoi tao i = 0
  
_sort.xuatketqua:
 
    

    push dword [ebx]
    push dword fmt2
    call _printf
    add esp,8
    
    ;Tang dia chi mang
    add ebx, 4
    ;Tang i
    inc esi
    ;Kiem tra i < n thi lap
    cmp esi, dword [n]
    jl _sort.xuatketqua
  
     pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret
    
    
    
    
    
;Dau thu tuc
global _sort
_sort:
    ;backup ebp
    push ebp
    mov ebp, esp; su dung stack lam vung nho co so
    ;Khai bao kich thuoc stack
    sub esp,64
    ;Backup thanh ghi neu can
    push ebx
    xor eax,eax
    

    
;Than thu tuc
    ;sum = 0
    ;i = 1
    
   mov eax,dword[ebx]
   add ebx,4
   cmp eax,[ebx]
   jg _swap
   jmp _sort.Thoat
   

_swap:
    mov edi,[ebx]; c=b
    mov [ebx],eax; b=a
    sub ebx,4
    mov [ebx],edi ;a=c

;Cuoi thu tuc
_sort.Thoat:
    
    ;Restore thanh ghi neu co
    pop ebx   
    ;Xoa stack
    add esp,64
    ;Khoi phuc ebp
    mov esp, ebp ; takedown stack frame 
    pop ebp
    ;Tra ve
    ret
;********************************************************************************
;xuat menu

_begin.Menu:
    push dword tb4
    call _printf
    add esp, 4
    
    push dword tb5
    call _printf
    add esp,4
    
    ;Nhap luachon
    push dword cmd
    push dword fmt1
    call _scanf
    add esp,8
    
    ;Khoi tao vong lap
    
    mov eax,[cmd]
    cmp eax,1
    je luaChon1
    cmp eax,2
    je luaChon2
    cmp eax,3
    je luaChon3
    cmp eax,4
    je luaChon4
    cmp eax,5
    je luaChon5
    cmp eax,6
    je luaChon6
    cmp eax,7
    je luaChon7
    cmp eax,8
    je luaChon8
    jmp _thoat
    
 luaChon1:
 call _NhapMang 
 jmp _begin.Menu  
    
luaChon2:
    call _XuatMang
    call _getch
    jmp _begin.Menu
luaChon3:
call _SoNT
call _getch
jmp _begin.Menu
luaChon4:
call _SoHT
call _getch
jmp _begin.Menu
luaChon5:
call _CP
call _getch
jmp _begin.Menu
luaChon6:
call _SoDX
call _getch
jmp _begin.Menu
luaChon7:
call _TimSoLonNhat
call _getch
jmp _begin.Menu
luaChon8:
call _sapXep
call _getch
jmp _begin.Menu
_thoat:
    push dword tb12
    call _printf
    add esp, 4
    call _getch
    xor eax, eax
    ret