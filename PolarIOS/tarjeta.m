
#import "ViewController.h"
#import "Openpay.h"

#define MERCHANT_ID @"m4puwlmcsisiixkrjer9"
#define API_KEY @"pk_cf106319591147c4bea14f78044a0a30"

@interface ViewController2 ()

@property (nonatomic) Openpay *openpayAPI;
@property NSString *sessionId;

@end

@implementation ViewController2

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];



    NSString *apikey = [userDefaults objectForKey:@"publicaopen"];
    NSString *idopen = [userDefaults objectForKey:@"idopen"];
    NSString *openproduccion = [userDefaults objectForKey:@"openproduccion"];
    if ([openproduccion  isEqual: @"FALSE"]) {
        _openpayAPI = [[Openpay alloc] initWithMerchantId:idopen apyKey:apikey isProductionMode:NO isDebug: YES];

    }else{
        _openpayAPI = [[Openpay alloc] initWithMerchantId:idopen apyKey:apikey isProductionMode:YES isDebug: YES];

    }
    
    _sessionId= [_openpayAPI createDeviceSessionId];
    [self.loadingIndicator setHidden:YES];

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitCardInfo {
    
    OPCard *card = [[OPCard alloc]init];
    card.holderName = [self.txtName text];
    card.number = [self.txtNumber text];
    card.expirationMonth = [self.txtExpMonth text];
    card.expirationYear = [self.txtExpYear text];
    card.cvv2 = [self.txtCVV2 text];
    

    [_openpayAPI createTokenWithCard:card
        success:^(OPToken *token) {
            [self setActivityIndicatorEnabled:NO];
       
        NSLog(@"textField: %@", self->_sessionId);
        NSLog(@"textField: %@", token.id);

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:token.id forKey:@"idtoken"];
        [defaults setObject:self->_sessionId forKey:@"deviceseisionid"];
        [defaults setObject:@"true" forKey:@"nuevatarjeta"];
        [defaults synchronize];
        [self setActivityIndicatorEnabled:YES];

        [self performSegueWithIdentifier:@"guardar" sender:self];
        } failure:^(NSError *error) {
            NSLog(@"Your message here.");
            // with parameters:
            NSString * myParam = @"Some value";
            NSLog(@"myParam:%@", myParam);
         UIAlertController * alert = [UIAlertController
                         alertControllerWithTitle:@"Datos incorrectos"
                                          message:@"Verifique la informaciòn"
                                   preferredStyle:UIAlertControllerStyleAlert];



         UIAlertAction* yesButton = [UIAlertAction
                             actionWithTitle:@"Aceptar"
                                       style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action) {
                                         //Handle your yes please button action here
                                     }];
            [self.btnAction setHidden:NO];
                    [self.btnReset setHidden:NO];
                    [self.loadingIndicator startAnimating];
                    [self.loadingIndicator setHidden:YES];


         [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];

    }];
}



- (IBAction) btnClick:(id)sender
{
    if(_txtNumber.text.length != 16 )
     {
           UIAlertController * alert = [UIAlertController
                                          alertControllerWithTitle:@"Solo se permite 16 digitos para la tarjeta"
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleAlert];

             //Add Buttons

             UIAlertAction* yesButton = [UIAlertAction
                                         actionWithTitle:@"Aceptar"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action) {
                                             //Handle your yes please button action here
                                         }];

          


             [alert addAction:yesButton];
         

             [self presentViewController:alert animated:YES completion:nil];
     }
  
   else if(_txtExpYear.text.length != 2 )
        {
              UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"Solo se permite 2 digitos para el año"
                                             message:@""
                                             preferredStyle:UIAlertControllerStyleAlert];

                //Add Buttons

                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"Aceptar"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                //Handle your yes please button action here
                                            }];

             


                [alert addAction:yesButton];
            

                [self presentViewController:alert animated:YES completion:nil];
        }
   else if(_txtExpMonth.text.length != 2 )
        {
              UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"Solo se permite 2 digitos para el mes"
                                             message:@""
                                             preferredStyle:UIAlertControllerStyleAlert];

                //Add Buttons

                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"Aceptar"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                //Handle your yes please button action here
                                            }];

             


                [alert addAction:yesButton];
            

                [self presentViewController:alert animated:YES completion:nil];
        }
    else if(_txtCVV2.text.length != 3 )
           {
                 UIAlertController * alert = [UIAlertController
                                                alertControllerWithTitle:@"Solo se permite 3 digitos en el CVV"
                                                message:@""
                                                preferredStyle:UIAlertControllerStyleAlert];

                   //Add Buttons

                   UIAlertAction* yesButton = [UIAlertAction
                                               actionWithTitle:@"Aceptar"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   //Handle your yes please button action here
                                               }];

                


                   [alert addAction:yesButton];
               

                   [self presentViewController:alert animated:YES completion:nil];
           }    
   else{
    [self.view endEditing:YES];
    [self setActivityIndicatorEnabled:YES];
    [self submitCardInfo];
   }
}

- (IBAction) btnReset:(id)sender {
    [self setActivityIndicatorEnabled:NO];
    [self resetForm];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)resetForm {
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            [(UITextField*)view setText:@""];
        }
    }
    [self.txtResponseView setText:@""];
}

- (void)setActivityIndicatorEnabled:(BOOL)enabled {
    if (enabled) {
        [self.btnAction setHidden:YES];
        [self.btnReset setHidden:YES];
        [self.loadingIndicator startAnimating];
        [self.loadingIndicator setHidden:NO];
    }
    else {
        [self.btnAction setHidden:NO];
        [self.btnReset setHidden:NO];
        [self.loadingIndicator startAnimating];
        [self.loadingIndicator setHidden:NO];
    }
}

@end
