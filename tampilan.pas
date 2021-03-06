program TiketKeretaApi;
uses crt;

type waktu = record
	jam : Integer;
	menit : Integer;
end;

type bangku = record
	nama : String;
	ID : String;
	hp : String;
	duduk : Boolean;
end;

type jadwalkereta = record
	nomor : Integer;
	asal : String;
	tujuan : String;
	berangkat : waktu;
	tiba : waktu;
	gerbong : Integer;
	tarif : Integer;
	kursi : array[1..4,1..10,1..4] of bangku;									//[gerbong,kolom(a,b,c,d),baris(1..10)]
end;

var
	u1,p1: String;    //u1,p1 yang dibaca program
	kon:Char;		  //kon, konfirmasi pilihan ya atau tidak
	jadwal : file of jadwalkereta;
	j: jadwalkereta;
	pil,i : Integer;
	carikereta : Integer;
	tiket : Integer;
	z,x,c : Integer;
	isi : Boolean;
	ketemu : Boolean;
	k : Char;

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
	clrscr;
	assign(jadwal,'JadwalKereta.dat');
	rewrite(jadwal);
	kon:='y';																		//memberi pernyataan bahwa akan masuk ke perulangan
	while (kon='y') or (kon='Y') do
	begin
		Masukkan();
	end;
	clrscr;
	write('Data telah disimpan.');
	close(jadwal);
end;

procedure Visualisasi();
begin
	read(jadwal,j);
	seek(jadwal,carikereta);
	for z := 1 to 4 do begin
		for x := 1 to 10 do begin
			for c := 1 to 4 do begin
				if (j.kursi[z,x,c].duduk) then begin
					write('X ');
				end
				else begin
					write('O ');
				end;
			end;
			writeln();
		end;
		writeln();
	end;
	reset(jadwal);
end;

procedure LihatKereta();
begin
	assign(jadwal,'JadwalKereta.dat');
	reset(jadwal);
	writeln('No.   Asal       Tujuan        Berangkat    Tiba     Tarif');
	for i := 1 to FileSize(jadwal) do begin
		read(jadwal,j);
		gotoxy(1,i+1); write(j.nomor); gotoxy(7,i+1); write(j.asal); gotoxy(18,i+1); write(j.tujuan);
		gotoxy(32,i+1); write(j.berangkat.jam,'.',j.berangkat.menit); gotoxy(45,i+1); write(j.tiba.jam,'.',j.tiba.menit);
		gotoxy(54,i+1); write(j.tarif); writeln();
	end;
	writeln();
	i:=FileSize(jadwal);
	write('Masukkan pilihan tujuan : '); readln(carikereta);
	if (carikereta>i) or (carikereta<=0) then begin
		clrscr;
		writeln('Daftar Kereta yang dipilih tidak ada');
	end
	else begin
		reset(jadwal);
		seek(jadwal,carikereta-1);
		Visualisasi();		
	end;
end;

function KolomConvert(a : Char): Integer;
begin
	case (a) of
	'A','a'	: KolomConvert:=1;
	'B','b'	: KolomConvert:=2;
	'C','c'	: KolomConvert:=3;
	'D','d'	: KolomConvert:=4;	
	end;
end;

procedure Transaksi();
begin
	assign(jadwal,'JadwalKereta.dat');
	reset(jadwal);
	writeln('No.   Asal       Tujuan        Berangkat    Tiba     Tarif');
	for i := 1 to FileSize(jadwal) do begin
		read(jadwal,j);
		gotoxy(1,i+1); write(j.nomor); gotoxy(7,i+1); write(j.asal); gotoxy(18,i+1); write(j.tujuan);
		gotoxy(32,i+1); write(j.berangkat.jam,'.',j.berangkat.menit); gotoxy(45,i+1); write(j.tiba.jam,'.',j.tiba.menit);
		gotoxy(54,i+1); write(j.tarif); writeln();
	end;
	writeln();
	write('Pilih Kereta yang akan dicek transaksi nya : '); readln(carikereta);
	if (carikereta>i) or (carikereta<=0) then begin
		clrscr;
		writeln('Daftar Kereta yang dipilih tidak ada');
	end
	else begin
		reset(jadwal);
		seek(jadwal,carikereta-1);
		write('Masukkan nomor gerbong      : '); readln(z);
		write('Masukkan baris tempat duduk : '); readln(x);
		write('Masukkan kolom tempat duduk : '); readln(k);
		c:=KolomConvert(k);
		read(jadwal,j);
		if (j.kursi[z,x,c].duduk) then begin
			seek(jadwal,carikereta-1);
			writeln('Nama Penumpang          : ',j.kursi[z,x,c].nama);
			writeln('No. Identitas Penumpang : ',j.kursi[z,x,c].ID);
			writeln('No. Handphone Penumpang : ',j.kursi[z,x,c].hp);
		end
		else begin
			writeln('Kursi kosong');
		end;
	end;
end;

procedure MenuAdmin();
begin
	repeat 																			//membuat kondisi agar setelah pilihan tidak keluar dari menu admin
		if (pil=4) then begin
			writeln('Terima kasih :)');
			exit;
		end
		else begin
		clrscr;
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
			readln();
		end;
		2	: begin
			clrscr;
			Transaksi(); readln();
		end;
		3	: begin
			clrscr;
			LihatKereta(); readln();
		end;
		4	: begin
			clrscr;
			writeln('Terima kasih :)');
		end;
			else
				begin
				clrscr;
				writeln('Input Anda Tidak Terdaftar. Akan exit program');
				readln();
				exit;
				end;
			end;			
		end;
	until (pil=4);
end;

function ConvertKolom(a : Integer): Char;
begin
	case (a) of
	1	: ConvertKolom:='A';
	2	: ConvertKolom:='B';
	3	: ConvertKolom:='C';
	4	: ConvertKolom:='D';	
	end;
end;

procedure Pemesanan();
begin
	assign(jadwal,'JadwalKereta.dat');
	reset(jadwal);
	writeln('No.   Asal       Tujuan        Berangkat    Tiba     Tarif');
	for i := 1 to FileSize(jadwal) do begin
		read(jadwal,j);
		gotoxy(1,i+1); write(j.nomor); gotoxy(7,i+1); write(j.asal); gotoxy(18,i+1); write(j.tujuan);
		gotoxy(32,i+1); write(j.berangkat.jam,'.',j.berangkat.menit); gotoxy(45,i+1); write(j.tiba.jam,'.',j.tiba.menit);
		gotoxy(54,i+1); write(j.tarif); writeln();
	end;
	writeln();
	write('Masukkan pilihan tujuan : '); readln(carikereta);
	case (carikereta) of
	1	: begin
		reset(jadwal);
		while (carikereta<>j.nomor) do
		begin
			read(jadwal,j);
		end;
	end;
	2	: begin
		reset(jadwal);
		while (carikereta<>j.nomor) do
		begin
			read(jadwal,j);
		end;
	end;
	3	: begin
		reset(jadwal);
		while (carikereta<>j.nomor) do
		begin
			read(jadwal,j);
		end;
	end;
	4	: begin
		reset(jadwal);
		while (carikereta<>j.nomor) do
		begin
			read(jadwal,j);
		end;
	end;
		else
			clrscr;
			writeln('Tujuan tidak ada');
		end;

	if (carikereta=j.nomor) then begin
		clrscr;
		writeln('No.   Asal       Tujuan        Berangkat    Tiba     Tarif');
		gotoxy(1,3); write(j.nomor); gotoxy(7,3); write(j.asal); gotoxy(18,3); write(j.tujuan);
		gotoxy(32,3); write(j.berangkat.jam,'.',j.berangkat.menit); gotoxy(45,3); write(j.tiba.jam,'.',j.tiba.menit);
		gotoxy(54,3); write(j.tarif); writeln();
		writeln();
		write('Masukkan jumlah tiket yang akan dipesan (maks 4) : '); readln(tiket);
		if (tiket>4) then begin
			clrscr;
			writeln('Mohon maaf. Jumlah tiket tidak dapat kami proses');
		end
		else begin
			clrscr;
			for i := 1 to tiket do begin
				z:=1;
				isi:=false;
				while (z<=4) and (not isi) do                       
				begin
					x:=1;
					while (x<=10) and (not isi) do 				  
					begin
						c:=1;
						while (c<=4) and (not isi) do 			  
						begin
							if (j.kursi[z,x,c].duduk=false) then begin
								seek(jadwal,carikereta-1);
								j.kursi[z,x,c].duduk:=true;
								isi:=true;
								write('Masukkan Nama Penumpang ',i,'          : '); readln(j.kursi[z,x,c].nama);
								write('Masukkan No. Identitas penumpang ',i,' : '); readln(j.kursi[z,x,c].ID);
								write('Masukkan No. Handphone penumpang ',i,' : '); readln(j.kursi[z,x,c].hp);
								writeln('Kursi di : ',z,' ',x,' ',ConvertKolom(c));
								write(jadwal,j);
								writeln('----------------------------------------------------------');
							end
							else c:=c+1;
						end;
						x:=x+1;
					end;
					z:=z+1;
				end;
			end;
		end;		
	end;
end;

procedure Batal();
var
	input: Char;
begin
	writeln('No. Identitas  : ',j.kursi[z,x,c].ID);
	writeln('Nama Penumpang : ',j.kursi[z,x,c].nama);
	writeln('No. Handphone  : ',j.kursi[z,x,c].hp);
	writeln();
	write('Apakah Anda ingin membatalkan pesanan? (y/n) : '); readln(input);
	case (input) of
	'y'	: begin
		j.kursi[z,x,c].nama:='';
		j.kursi[z,x,c].ID:='';
		j.kursi[z,x,c].duduk:=false;
		j.kursi[z,x,c].hp:='';
		write(jadwal,j);
		writeln('Pembatalan berhasil dilakukan');
	end;
		else
			writeln('Pembatalan pesanan gagal');
		end;
end;

procedure Edit();
begin
	write('Masukkan Nama Penumpang          : '); readln(j.kursi[z,x,c].nama);
	write('Masukkan No. Identitas penumpang : '); readln(j.kursi[z,x,c].ID);
	write('Masukkan No. Handphone penumpang : '); readln(j.kursi[z,x,c].hp);
	write(jadwal,j);
end;

procedure Batalkan();
var
	IDs: String;
begin
	write('Masukkan No. Identitas yang Anda cari : '); readln(IDs);
	ketemu:=false;
	assign(jadwal,'JadwalKereta.dat');
	reset(jadwal);
	i:=1;
	while (i<=FileSize(jadwal)) and (not ketemu) do
	begin
		read(jadwal,j);
		z:=1;
		while (z<=4) and (not ketemu) do
		begin
			x:=1;
			while (x<=10) and (not ketemu) do
			begin
				c:=1;
				while (c<=4) and (not ketemu) do
				begin
					if (IDs=j.kursi[z,x,c].ID) then begin
						ketemu:=true;
						writeln('1. Edit');
						writeln('2. Batalkan');
						writeln();
						write('Masukkan pilihan Anda : '); readln(pil);
						case (pil) of
						1	: begin
							Edit();
						end;
						2	: begin
							Batal();
						end;
							else
								clrscr;
								writeln('Input tidak Terdaftar');
							end;
					end
					else begin
						c:=c+1;						
					end;
				end;
				x:=x+1;
			end;
			z:=z+1
		end;
		i:=i+1;
	end;
	if (ketemu=false) then begin
		writeln('Data tidak ditemukan');
	end;
end;

procedure MenuUser();
begin
	repeat 																			//membuat kondisi agar setelah pilihan tidak keluar dari menu admin
		if (pil=3) then begin
			writeln('Terima kasih :)');
			exit;
		end
		else begin
		clrscr;
		writeln('1. Pesan tiket');
		writeln('2. Edit / Batalkan pesanan');
		writeln();
		writeln('3. Keluar');
		writeln();
		write('Masukkan Pilihan : '); readln(pil);
		case (pil) of
		1	: begin
			clrscr;
			Pemesanan();
			readln();
		end;
		2	: begin
			clrscr;
			Batalkan();
			readln();
		end;
		3	: begin
			clrscr;
			writeln('Terima kasih :)');
		end;
			else
				begin
				clrscr;
				writeln('Input Anda Tidak Terdaftar. Akan exit program');
				readln();
				exit;
				end;
			end;			
		end;
	until (pil=3);
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
		MenuUser();
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