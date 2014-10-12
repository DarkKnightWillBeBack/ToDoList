//
//  WeatherViewController.m
//  start
//
//  Created by 谢润丰 on 14-10-11.
//  Copyright (c) 2014年 StarkIndustry. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@property NSDictionary *weatherInfo;

@end

@implementation WeatherViewController

- (void)fetchdata:(NSData *)responddata{
    NSError *error;
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:responddata options:kNilOptions error:&error];
    _weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
}

- (void)loadWeather{
    _weather.text = [NSString stringWithFormat:@"今天%@的气温是%@到%@\n天气%@",[_weatherInfo objectForKey:@"city"],[_weatherInfo objectForKey:@"temp1"],[_weatherInfo objectForKey:@"temp2"],[_weatherInfo objectForKey:@"weather"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       NSData *WeatherData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.weather.com.cn/data/cityinfo/101020100.html"]];
        [self performSelector:@selector(fetchdata:) withObject:WeatherData];
        [self performSelectorOnMainThread:@selector(loadWeather) withObject:WeatherData waitUntilDone:YES];
    });
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
