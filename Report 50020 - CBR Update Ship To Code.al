report 50020 "Update Ship-To Code"
{
    DefaultLayout = RDLC;
    RDLCLayout = './UpdateShipToCode.rdl';

    dataset
    {
        dataitem("Ship-to Address2"; "CBR Ship-to Address2")
        {

            trigger OnAfterGetRecord()
            begin
                ShipToAddress.Reset;
                ShipToAddress.SetRange("Customer No.", "Customer No.");
                ShipToAddress.SetRange(Name, Name);
                ShipToAddress.SetRange(Contact, Address);
                ShipToAddress.SetRange(Address, "Address 2");

                //ShipToAddress.SETRANGE(Address,Address);
                //ShipToAddress.SETRANGE(Contact,"Address 2");
                //ShipToAddress.SETRANGE(City,City);
                if ShipToAddress.FindFirst then begin
                    if ShipToAddress."CBR Old Ship-To Code" = '' then
                        ShipToAddress."CBR Old Ship-To Code" := Code;
                    ShipToAddress.Modify;
                end
            end;

            trigger OnPostDataItem()
            begin
                Message('completed');
            end;
        }
        dataitem("Ship-to Address"; "Ship-to Address")
        {

            trigger OnAfterGetRecord()
            begin
                // "Ship-to Address"."Old Ship-To Code":='';
                // "Ship-to Address".MODIFY;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ShipToAddress: Record "Ship-to Address";
}

