//
//  ViewController.m
//  XMLWithiOS
//
//  Created by linx214 on 15/10/14.
//  Copyright © 2015年 linx214. All rights reserved.
//

/**
 完成简历技能描述内容，XML文件的解析
 2015-10-14 01:32:13 start
 2015-10-14 03:53:28 end
 */

#import "ViewController.h"

@interface ViewController () <NSXMLParserDelegate>

@property (strong, nonatomic) NSXMLParser* parser;
@property (strong, nonatomic) NSMutableString* strSaxResult;
@property (strong, nonatomic) NSMutableString* strTmpSax;

@end

@implementation ViewController

- (NSMutableString*)strSaxResult
{
    if (!_strSaxResult)
        _strSaxResult = [[NSMutableString alloc] init];
    
    return _strSaxResult;
}

- (NSMutableString*)strTmpSax
{
    if (!_strTmpSax)
        _strTmpSax = [[NSMutableString alloc] init];
    
    return _strTmpSax;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL* fileUrl = [[NSBundle mainBundle] URLForResource:@"xmlFormat" withExtension:@"xml"];
    NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:fileUrl];
    self.parser = xmlParser;
    xmlParser.delegate = self;
    if (!xmlParser)
    {
        NSLog(@"xmlParser init failed!");
    }
    else
    {
        NSLog(@"xmlParser init successed!");
    }
    
    xmlParser.shouldProcessNamespaces = YES;
    xmlParser.shouldReportNamespacePrefixes = YES;
    xmlParser.shouldGroupAccessibilityChildren = YES;
    xmlParser.shouldResolveExternalEntities = YES;
    
    [xmlParser parse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"xml columns: %ld", [self.parser columnNumber]);
    NSLog(@"xml lines: %ld", [self.parser lineNumber]);
    NSLog(@"xml systemID: %@", [self.parser systemID]);
    NSLog(@"xml publicID: %@", [self.parser publicID]);
    NSLog(@"RESULT: %@", self.strSaxResult);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"elementName: %@, namespaceURI: %@, qName: %@, attributeDict: %@", elementName, namespaceURI, qName, attributeDict);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"elementName: %@, namespaceURI: %@, qName: %@", elementName, namespaceURI, qName);
    if (NSOrderedSame == [elementName compare:@"name"] ||
        NSOrderedSame == [elementName compare:@"password"] ||
        NSOrderedSame == [elementName compare:@"age"])
        [self.strSaxResult appendFormat:@"%@: %@\r\n", elementName, self.strTmpSax];
    else if (NSOrderedSame == [elementName compare:@"Root"] ||
             NSOrderedSame == [elementName compare:@"user"])
    {
        
    }
}

- (void)parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.strTmpSax setString:@""];
    [self.strTmpSax appendFormat:@"%@", string];
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    NSLog(@"found CDATA");
}

- (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue
{
    NSLog(@"found ArrributeDeclarationWithName: %@, forElement: %@, type: %@, defaultValue: %@", attributeName, elementName, type, defaultValue);
}

- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment
{
    NSLog(@"found comment: %@", comment);
}

- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model
{
    NSLog(@"found ElementDeclarationWithName: %@, model: %@", elementName, model);
}

- (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID
{
    NSLog(@"foundExternalEntityDeclarationWithName: %@, publicID: %@, systemID: %@", name, publicID, systemID);
}

- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString
{
    NSLog(@"foundIgnorableWhitespace: %@", whitespaceString);
}

- (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value
{
    NSLog(@"foundInternalEntityDeclarationWithName: %@, value: %@", name, value);
}

- (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID
{
    NSLog(@"foundNotationDeclarationWithName: %@, publicID: %@, systemID: %@", name, publicID, systemID);
}

- (void)parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(NSString *)data
{
    NSLog(@"foundProcessingInstructionWithTarget: %@, data: %@", target, data);
}

- (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID notationName:(NSString *)notationName
{
    NSLog(@"foundUnparsedEntityDeclarationWithName: %@, publicID: %@, systemID: %@, notationName: %@", name, publicID, systemID, notationName);
}

@end
