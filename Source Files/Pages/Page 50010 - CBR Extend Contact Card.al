pageextension 50010 CBRExtendContactCard extends "Contact Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Type)
        {
            field("CBR Lead Type"; "CBR Lead Type")
            {
                ApplicationArea = All;
                Caption = 'Contact Type';
            }
        }
    }

    actions
    {
        modify(CreateAsCustomer)
        {
            ApplicationArea = all;

            trigger OnBeforeAction()
            begin
                //CBR_SS_08052017..>>
                IF Rec.Type = Rec.Type::Person THEN
                    ERROR('A Person cannot be converted to a Customer');
                //CBR_SS_08052017..>>
            end;
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}