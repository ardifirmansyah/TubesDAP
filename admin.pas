{
														perhatikan lagi assign file saat konversi ke procedure
																assign dilakukan diawal program utama
									  						  agar record file sebelumnya tidak terhapus
}



program inputjadwal;
uses crt;

type waktu = record
	jam : Integer;
	menit : Integer;
end;

type jadwalkereta = record
	asal : String;
	tujuan : String;
	berangkat : waktu;
	tiba : waktu;
	gerbong : Integer;
	tarif : Integer;	
end;

var
	jadwal : file of jadwalkereta;
	j: jadwalkereta;
	kon: Char;

procedure Masukkan();
begin
	clrscr;
	write('Masukkan asal kereta : '); readln(j.asal);
	write('Masukkan tujuan kereta : '); readln(j.tujuan);
	write('Masukkan jam keberangkatan : '); readln(j.berangkat.jam);
	write('Masukkan menit keberangkatan : '); readln(j.berangkat.menit);
	write('Masukkan jam tiba : '); readln(j.tiba.jam);
	write('Masukkan menit tiba : '); readln(j.tiba.menit);
	write('Masukkan jumlah gerbong : '); readln(j.gerbong);
	write('Masukkan tarif : '); readln(j.tarif);
	write(jadwal,j);                                                                //memindahkan record (j) ke file (jadwal)
	writeln();
	writeln('Data telah disimpan. Input lagi? (y/n) : '); readln(kon);
end;

begin
	assign(jadwal,'JadwalKereta.dat');
	rewrite(jadwal);
	kon:='y';																		//memberi pernyataan bahwa akan masuk ke perulangan
	while (kon='y') or (kon='Y') do
	begin
		Masukkan();
	end;
end.
