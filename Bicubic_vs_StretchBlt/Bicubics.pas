{
Bicubic Interpolation for Image Scaling
http://paulbourke.net/texture_colour/imageprocess/

Original C code Written by Paul Bourke
http://paulbourke.net/libraries/bitmaplib.c

Pascal version by Cirec 2012
  add: Callback methode to step a ProgressBar

}

unit Bicubics;

interface

uses Windows, Graphics;

type
  TObjectProc = procedure of object;

procedure BiCubicScale(const bm_in: TBitmap; const nx, ny: Integer;
   const bm_out: TBitmap; const nnx, nny: Integer; const ProgressCallBack: TObjectProc = nil);



implementation
function BiCubicR(const x: Extended): Extended;
var
   xp2,xp1,xm1: Extended;
   r: Extended;
begin
   R := 0;
   xp2 := x + 2;
   xp1 := x + 1;
   xm1 := x - 1;

   if xp2 > 0 then
      r := r + xp2 * xp2 * xp2;
   if xp1 > 0 then
      r := r - 4 * xp1 * xp1 * xp1;
   if x > 0 then
      r := r + 6 * x * x * x;
   if xm1 > 0 then
      r := r - 4 * xm1 * xm1 * xm1;

   Result := r / 6.0;
end;


{
	Scale an image using bicubic interpolation
}
procedure BiCubicScale(const bm_in: TBitmap; const nx, ny: Integer;
   const bm_out: TBitmap; const nnx, nny: Integer; const ProgressCallBack: TObjectProc = nil);
var
   i_out,j_out,i_in,j_in,ii,jj: Integer;
   n,m: Integer;
	 index: Integer;
   cx,cy,dx,dy,weight,
   red,green,blue,alpha: Extended;
   col: RGBQuad;
   Pbm_In, Pbm_Out: Cardinal;
begin
  bm_In.PixelFormat := pf32bit;
  bm_Out.PixelFormat := pf32bit;
  Pbm_In := Cardinal(bm_In.ScanLine[ny-1]);
  Pbm_Out := Cardinal(bm_Out.ScanLine[nny-1]);
  for j_out := 0 to nny-1 do
  begin
    for i_out := 0 to nnx-1 do
    begin
      i_in := (i_out * nx) div nnx;
      j_in := (j_out * ny) div nny;
      cx := i_out * nx / nnx;
      cy := j_out * ny / nny;
      dx := cx - i_in;
      dy := cy - j_in;
      red   := 0;
      green := 0;
      blue  := 0;
      alpha := 0;
      for m := -1 to 2 do
        for n := -1 to 2 do
        begin
          ii := i_in + m;
          jj := j_in + n;
          if ii < 0 then  ii := 0;
          if ii >= nx then ii := nx-1;
          if jj < 0 then jj := 0;
          if jj >= ny then jj := ny-1;
          index := jj * nx + ii;
          weight := BiCubicR(m-dx) * BiCubicR(n-dy);
//           weight := BiCubicR(dx-m) * BiCubicR(dy-n);
          with PRGBQuad(index * 4 + Pbm_In)^ do
          begin
            red := red + weight * rgbRed;
            green := green + weight * rgbGreen;
            blue := blue + weight * rgbBlue;
            alpha := alpha + weight * rgbReserved;
          end;
        end;
      col.rgbRed := Trunc(red);
      col.rgbGreen := Trunc(green);
      col.rgbBlue := Trunc(blue);
      col.rgbReserved := Trunc(alpha);
      PRGBQuad((j_out * nnx + i_out) * 4 + Pbm_Out)^ := col;
    end;
    if Assigned(ProgressCallBack) then
      ProgressCallBack;
  end;

end;


end.
