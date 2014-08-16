class SpritzerController < ApplicationController



	<script type="text/javascript">
	     var SpritzSettings = {
	               clientId: "6c3a147d2cd7d078b",
	               redirectUri:"http://www.shadowmsg.com/messages/login_success"
	     };
	</script> 
	<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="//sdk.spritzinc.com/js/1.2/js/spritz.min.js"></script>
	
	var onStartSpritzClick = function(event) {
    var text = $('#inputText').val();
    var locale = "en_us;";
 
    // Send to SpritzEngine to translate
    SpritzClient.spritzify(text, locale, onSpritzifySuccess, onSpritzifyError);
    };

    var onSpritzifySuccess = function(spritzText) {
      spritzController.startSpritzing(spritzText); 
    };	
end
