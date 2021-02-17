tableextension 50014 CBRExtendReservationEntry extends "Reservation Entry"
{
    fields
    {
        field(50001; "CBR Unused"; Boolean)
        {
            Caption = 'Unused';
            DataClassification = CustomerContent;

        }
    }

    var
        myInt: Integer;
}