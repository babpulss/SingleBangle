/**
 * 
 */

 $('#printInvoice').click(function(){
            Popup($('.invoice')[0].outerHTML);
            function Popup(data) 
            {
                window.print();
                return true;
            }
        });
 $(function(){
		$(".income").css("color","dodgerblue");
		$(".expense").css("color","red");
		
	});