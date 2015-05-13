program TiketKeretaApi;
uses crt;

var
	u1,p1: String;    //u1,p1 yang dibaca program
	kon:Char;		  //kon, konfirmasi pilihan ya atau tidak

const
	uc = 'user';
	pc = 'user';
	ua = 'admin';
	pa = 'admin';


procedure MenuUtama();
begin
	clrscr;
	write('Masukkan username : '); readln(u1);
	write('Masukkan password : '); readln(p1);
	if (u1 = uc) and (p1 = pc) then
	begin
		clrscr;
		kon:='a';                                                   //memberi status keluar dari perulangan
		writeln('Menu User');
	end
	else if (u1 = ua) and (p1 = pa) then 
	begin
		clrscr;
		kon:='a';													//memberi status keluar dari perulangan
		writeln('Menu Admin');
	end
	else
	begin
		writeln();
		writeln('Username atau password yang Anda masukkan salah');
		write('Coba lagi? (y/n) : '); readln(kon);
	end;
end;



begin
	repeat 															//menggunakan repeat karena sudah pasti dilakukan minimal 1 kali
		MenuUtama();
	until (kon<>'y');												//keluar perulangan jika kon <> y
end.