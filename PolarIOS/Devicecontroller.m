
#import "DeviceHeader.h"
#import "Openpay.h"
#define MERCHANT_ID @"m4puwlmcsisiixkrjer9"
#define API_KEY @"pk_cf106319591147c4bea14f78044a0a30"
//#define MERCHANT_ID @"m4tzxvoqsrbwdwueceeq"
//#define API_KEY @"pk_c4959aea8ebb4d4f94d9255a46c0eca1"
@interface DeviceHeader ()

@property (nonatomic) Openpay *openpay;
@property NSString *sessionId;

@end

@implementation DeviceHeader

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self myFunction];
    [self performSegueWithIdentifier:@"go" sender:self];
    // to use a point that is (109, 63) from the centre as the point to scale around
 CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 10.0f);
    _progres.transform = transform;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self performSegueWithIdentifier:@"go" sender:self];

}


- (void)myFunction {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSString *apikey = [userDefaults objectForKey:@"publicaopen"];
    NSString *idopen = [userDefaults objectForKey:@"idopen"];
    NSString *openproduccion = [userDefaults objectForKey:@"openproduccion"];
    if ([openproduccion  isEqual: @"FALSE"]) {
        _openpay = [[Openpay alloc] initWithMerchantId:idopen apyKey:apikey isProductionMode:NO isDebug: YES];

    }else{
        _openpay = [[Openpay alloc] initWithMerchantId:idopen apyKey:apikey isProductionMode:YES isDebug: YES];

    }
    
    _sessionId = [_openpay createDeviceSessionId];
    NSLog(@"textField: %@", self->_sessionId);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self->_sessionId forKey:@"deviceseisionid"];
    [defaults setObject:@"true" forKey:@"nuevatarjeta"];
    [defaults synchronize];

}


- (IBAction)go:(id)sender {

    [self performSegueWithIdentifier:@"go" sender:self];

}
@end
