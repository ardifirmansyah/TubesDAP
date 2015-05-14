program TiketKeretaApi;
uses crt;

type waktu = record
	jam : Integer;
	menit : Integer;
end;

type jadwalkereta = record
	nomor : Integer;
	asal : String;
	tujuan : String;
	berangkat : waktu;
	tiba : waktu;
	gerbong : Integer;
	tarif : Integer;	
end;

var
	u1,p1: String;    //u1,p1 yang dibaca program
	kon:Char;		  //kon, konfirmasi pilihan ya atau tidak
	jadwal : file of jadwalkereta;
	j: jadwalkereta;
	pil : Integer;

const
	uc = 'user';
	pc = 'user';
	ua = 'admin';
	pa = 'admin';

procedure Masukkan();
begin
	clrscr;
	write('Masukkan Nomor Kereta : '); readln(j.nomor);
	write('Masukkan stasiun asal : '); readln(j.asal);
	write('Masukkan stasiun tujuan : '); readln(j.tujuan);
	write('Masukkan jam keberangkatan : '); readln(j.berangkat.jam);
	write('Masukkan menit keberangkatan : '); readln(j.berangkat.menit);
	write('Masukkan jam tiba : '); readln(j.tiba.jam);
	write('Masukkan menit tiba : '); readln(j.tiba.menit);
	write('Masukkan jumlah gerbong : '); readln(j.gerbong);
	write('Masukkan tarif : '); readln(j.tarif);
	write(jadwal,j);                                                                //memindahkan record (j) ke file (jadwal)
	writeln();
	write('Data telah disimpan. Input lagi? (y/n) : '); readln(kon);
end;

procedure InputJadwal();
begin
	assign(jadwal,'JadwalKereta.dat');
	write(jadwal);
	kon:='y';																		//memberi pernyataan bahwa akan masuk ke perulangan
	while (kon='y') or (kon='Y') do
	begin
		Masukkan();
	end;
	clrscr;
	write('Data telah disimpan. Akan exit program'); readln();
end;

procedure MenuAdmin();
begin
	writeln('1. Input Jadwal Kereta');
	writeln('2. Lihat Daftar Transaksi');
	writeln('3. Lihat Detil Kereta');
	writeln();
	writeln('4. Keluar');
	writeln();
	write('Masukkan Pilihan : '); readln(pil);
	case (pil) of
	1	: begin
		clrscr;
		InputJadwal();
	end;
	2	: begin
		clrscr;
		writeln('Menu Lihat Daftar Transaksi');
	end;
	3	: begin
		clrscr;
		writeln('Menu Detil Kereta');
	end;
	4	: begin
		exit;
	end;
		else
			begin
			clrscr;
			writeln('Input Anda Tidak Terdaftar. Akan exit program');
			end;
		end;
end;

procedure Login();
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
		MenuAdmin();
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
		Login();
	until (kon<>'y');												//keluar perulangan jika kon <> y
end.