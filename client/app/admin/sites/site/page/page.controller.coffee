'use strict'

angular.module 'mydrive5App'
.controller 'PageCtrl', ($scope,$stateParams,Sites) ->
  console.log 'page ctrl'  
  $scope.pageSaving=false

  init=->
    $scope.page=Sites.findPage($scope.site,$stateParams.page)
    if typeof $scope.page.template == 'undefined'
      $scope.page.template=$scope.templates[0]

  $scope.save=->
    $scope.pageSaving=true
    Sites.savePage($scope.site,$scope.page)
    .then (response)->
      console.log response
      $scope.site=response.data[0]
      init()
      $scope.pageSaving=false









  default1='<h1>Hello, world!</h1><p>This is a template for a simple welcome website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>'
  faq='<h3>How do I make a donation?</h3> <p>You can make a donation by credit card or check by visiting the donate page on our website.</p> <h3>How do I make a check donation?</h3> <p>To make a donation by check, select &#8220;check&#8221; from the &#8220;I will be paying by&#8221; line on the donation page. After submitting your donation, print the invoice that automatically appears on your screen. If you forget to print this invoice, simply print a copy of the Thank You email you will receive at the email address you provide, because it contains the same information.</p> <p>Please mail your invoice and check made out to FUNDRAISER to our check processing address. Please make sure you write the address exactly as it appears below:</p> <p>FUNDRAISER<br /> L-3454<br /> Columbus, Ohio 43260-3454</p> <p>Please note, the above address accepts USPS mail only.</p> <h3>What do I do if a donor hands me a check?</h3> <p>Please mail the check to our check processing address and make sure the address is written exactly as it appears above. Also, be sure that your Rider ID and name are included in the memo line, so that we may appropriately apply the donation to your ride. If the donor made the check out to your name, you are able to sign the check over to FUNDRAISER prior to mailing it in by writing “Pay to the order of FUNDRAISER” in the endorsement area on the back of the check along with your signature.</p> <h3>Why do you ask for so much donor information?</h3> <p>The data we collect is necessary to create accurate donor records and provide appropriate tax acknowledgement information. The information is not used for solicitation purposes. If you have any questions about the information that is being collected, please contact FUNDRAISER at <a href="mailto:FUNDRAISER@FUNDRAISER.org">FUNDRAISER@FUNDRAISER.org</a>.</p> <h3>How does FUNDRAISER handle tax acknowledgement receipts for cash donations?</h3> <p>If you would like a tax acknowledgment receipt, it is always best to make a credit card or check donation. FUNDRAISER cannot issue tax acknowledgement receipts for cash donations that are not brought directly to the FUNDRAISER office by the actual donor. Please do not send cash through the mail.</p> <p>If you are a donor who wants FUNDRAISER to issue an official tax acknowledgment receipt to you for a cash donation, you must bring the cash donation to the FUNDRAISER office yourself. FUNDRAISER cannot issue a tax acknowledgement receipt for a cash donation that is submitted to FUNDRAISER by someone other than the actual donor.</p>'
  navButton={title:'nav button',destination:'',disabled:false}
  $scope.templates=[
    {
      src:'defaultLayout'
      label:'welcome'
      default:
        block3:default1
        image3:{}
        block2:default1
        button2:{}
        image2:{}
        block1:default1
        button1:{}
        header1:default1
        image1:{}
    }
    {
      src:'contactLayout'
      label:'contact'
      contact:
        content1:'<h1><u>Example Contact Info</u></h1> <p>&nbsp;</p> <h4><span style="color:rgb(0, 0, 0)">George Blanchette</span><br /> <span style="color:rgb(0, 0, 0)">15 Cliff Street</span><br /> <span style="color:rgb(0, 0, 0)">Griswold CT 06351</span></h4> <p><strong>Click for:&nbsp;</strong><strong><a href="https://www.google.com/maps/dir/Current+Location/15+Cliff+Street+Griswold+CT+06351">Directions</a>&nbsp;</strong></p> <p><strong>Tel:</strong><a href="tel://1-510-434-1344"><strong>&nbsp;</strong>(510)-434-1344</a><br /> <strong>Email:&nbsp;</strong><a href="mailto:example@example.com">example@example.com</a></p> <p>&nbsp;</p> <h2><span style="color:rgb(0, 0, 0)">Ken Burns</span></h2> <h4><span style="color:rgb(0, 0, 0)">233 River Road&nbsp;&diams;&nbsp;New London CT 06320 &diams;&nbsp;</span><a href="tel://1-510-434-1344" style="line-height: 19.999979019165px; background-color: rgb(255, 255, 255);">(510)-434-1344</a>&nbsp;&diams;&nbsp;<a href="mailto:example@example.com" style="line-height: 19.999979019165px; background-color: rgb(255, 255, 255);">example@example.com</a></h4>'
    }
    {
      src:'blogLayout'
      label:'blog'
      blog:
        header:'<h1>My blog header</h1>'
        subHeader:'<h2>This is my blog subheader</h2>'
        about:'<p><em>This is my about section.</em>This is my about section, I can edit it any way that I may want. I may edit it any way that I want</p>'
    }
    {
      src:'faqLayout'
      label:'FAQ'
      faq:
        header1:'<h1>My FAQ header</h1>'
        faqs:[
          {title:'Fundraiser Questions',content:faq}
          {title:'General Questions',content:faq}
          {title:'Event Questions',content:faq}
        ]
    }
    {src:'participantLayout'
    label:'participant profile'}
    {src:'eventInfoLayout'
    label:'event info'}
  ]

  init()



  

