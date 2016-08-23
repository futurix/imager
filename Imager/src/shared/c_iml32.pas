unit c_iml32;

interface

uses
  Windows, SysUtils, Classes, StdCtrls, Controls, Graphics, Consts, CommCtrl;
  
procedure ConvertTo32BitImageList(const iml: TImageList);


implementation

procedure ConvertTo32BitImageList(const iml: TImageList);
const
	Mask: array[Boolean] of Longint = (0, ILC_MASK);
var
	TempList: TImageList;
begin
	if Assigned(iml) then
		begin
		TempList := TImageList.Create(nil);

        try
			TempList.Assign(iml);

			with iml do
				begin
				Handle := ImageList_Create(Width, Height, ILC_COLOR32 or Mask[Masked], 0, AllocBy);

				if not HandleAllocated then
					raise EInvalidOperation.Create(SInvalidImageList);
				end;

			iml.AddImages(TempList);

			finally
				FreeAndNil(TempList);
			end;
		end;
end;

end.
