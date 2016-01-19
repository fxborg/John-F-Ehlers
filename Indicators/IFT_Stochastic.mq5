//+------------------------------------------------------------------+
//|                                               IFT_Stochastic.mq5 |
//| IFT_Stochastic                            Copyright 2016, fxborg |
//|                                   http://fxborg-labo.hateblo.jp/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, fxborg"
#property link      "http://fxborg-labo.hateblo.jp/"
#property version   "1.00"
#property indicator_separate_window

#include <MovingAverages.mqh>

enum RANGE_MODE{CLOSE=1,HIGH_LOW=2};

#property indicator_minimum 0
#property indicator_maximum 100


#property indicator_level1 20
#property indicator_level2 50
#property indicator_level3 80

#property indicator_levelcolor Silver

#property indicator_buffers 41
#property indicator_plots 3

#property indicator_type1         DRAW_LINE
#property indicator_color1        clrDodgerBlue
#property indicator_width1 2

input int InpKPeriod=8;  // K period
input int InpDPeriod=3;  // D period
input int InpSlowing=3;  // Slowing
input RANGE_MODE InpRangeMode=HIGH_LOW;     // High Low Method
input int EMAPeriod=34;

int                  ma_period=10;                 // period of ma
int                  ma_shift=0;                   // shift

ENUM_MA_METHOD       ma_method=MODE_LWMA;          // type of smoothing
ENUM_APPLIED_PRICE   applied_price=PRICE_CLOSE;    // type of price

double wma0[];
double wma1[];
double wma2[];
double wma3[];
double wma4[];
double wma5[];
double wma6[];
double wma7[];
double wma8[];
double wma9[];
double wma0h[];
double wma1h[];
double wma2h[];
double wma3h[];
double wma4h[];
double wma5h[];
double wma6h[];
double wma7h[];
double wma8h[];
double wma9h[];
double wma0l[];
double wma1l[];
double wma2l[];
double wma3l[];
double wma4l[];
double wma5l[];
double wma6l[];
double wma7l[];
double wma8l[];
double wma9l[];

double ema0[];
double ema1[];
double rainbow[];
double rainbow_h[];
double rainbow_l[];
double osc[];
double bufsp[];
double bufpos[];
double sosc[];
double sig[];
double fish[];

int min_rates_total=10;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void dbgn(string arrName,double &arr[],int nMax)
  {
   string out;

   StringAdd(out,arrName);
   for(int i=0; i<nMax; i++)
      StringAdd(out,StringFormat(" f[%d] %f",i,arr[i]));

   Print(out);
  }
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   int n=0;
   SetIndexBuffer(n++,fish,INDICATOR_DATA);
   SetIndexBuffer(n++,rainbow,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,rainbow_h,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,rainbow_l,INDICATOR_CALCULATIONS);

   SetIndexBuffer(n++,sig,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,sosc,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,ema0,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,osc,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,ema1,INDICATOR_CALCULATIONS);
//--- 
   SetIndexBuffer(n++,wma0,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma1,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma2,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma3,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma4,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma5,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma6,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma7,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma8,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma9,INDICATOR_CALCULATIONS);
//--- 
   SetIndexBuffer(n++,wma0h,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma1h,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma2h,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma3h,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma4h,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma5h,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma6h,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma7h,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma8h,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma9h,INDICATOR_CALCULATIONS);
//--- 
   SetIndexBuffer(n++,wma0l,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma1l,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma2l,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma3l,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma4l,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma5l,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma6l,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma7l,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma8l,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,wma9l,INDICATOR_CALCULATIONS);
//--- 
   SetIndexBuffer(n++,bufpos,INDICATOR_CALCULATIONS);
   SetIndexBuffer(n++,bufsp,INDICATOR_CALCULATIONS);
//--- 

   PlotIndexSetDouble(0,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,0);
//--- digits
   IndicatorSetInteger(INDICATOR_DIGITS,2);
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   int i,first;
   if(rates_total<=min_rates_total)
      return(0);
//---
   int begin_pos=min_rates_total;

   first=begin_pos;
   if(first+1<prev_calculated) first=prev_calculated-2;

//---
   for(i=first; i<rates_total && !IsStopped(); i++)
     {
      wma0[i]=(close[i]*2+close[i-1])/3;   
      wma0h[i]=(high[i]*2+high[i-1])/3;   
      wma0l[i]=(low[i]*2+low[i-1])/3;
      if(i<=begin_pos+1)continue;
      wma1[i]=(wma0[i]*2+wma0[i-1])/3;     wma1h[i]=(wma0h[i]*2+wma0h[i-1])/3;  wma1l[i]=(wma0l[i]*2+wma0l[i-1])/3;
      if(i<=begin_pos+2)continue;
      wma2[i]=(wma1[i]*2+wma1[i-1])/3;     wma2h[i]=(wma1h[i]*2+wma1h[i-1])/3;  wma2l[i]=(wma1l[i]*2+wma1l[i-1])/3;
      if(i<=begin_pos+3)continue;
      wma3[i]=(wma2[i]*2+wma2[i-1])/3;     wma3h[i]=(wma2h[i]*2+wma2h[i-1])/3;  wma3l[i]=(wma2l[i]*2+wma2l[i-1])/3;
      if(i<=begin_pos+4)continue;
      wma4[i]=(wma3[i]*2+wma3[i-1])/3;     wma4h[i]=(wma3h[i]*2+wma3h[i-1])/3;  wma4l[i]=(wma3l[i]*2+wma3l[i-1])/3;
      if(i<=begin_pos+5)continue;
      wma5[i]=(wma4[i]*2+wma4[i-1])/3;     wma5h[i]=(wma4h[i]*2+wma4h[i-1])/3;  wma5l[i]=(wma4l[i]*2+wma4l[i-1])/3;
      if(i<=begin_pos+6)continue;
      wma6[i]=(wma5[i]*2+wma5[i-1])/3;     wma6h[i]=(wma5h[i]*2+wma5h[i-1])/3;  wma6l[i]=(wma5l[i]*2+wma5l[i-1])/3;
      if(i<=begin_pos+7)continue;
      wma7[i]=(wma6[i]*2+wma6[i-1])/3;     wma7h[i]=(wma6h[i]*2+wma6h[i-1])/3;  wma7l[i]=(wma6l[i]*2+wma6l[i-1])/3;
      if(i<=begin_pos+8)continue;
      wma8[i]=(wma7[i]*2+wma7[i-1])/3;     wma8h[i]=(wma7h[i]*2+wma7h[i-1])/3;  wma8l[i]=(wma7l[i]*2+wma7l[i-1])/3;
      if(i<=begin_pos+9)continue;
      wma9[i]=(wma8[i]*2+wma8[i-1])/3;     wma9h[i]=(wma8h[i]*2+wma8h[i-1])/3;  wma9l[i]=(wma8l[i]*2+wma8l[i-1])/3;

      int i1st=begin_pos+10;
      if(i<=i1st)continue;
      rainbow[i]=(5*wma0[i]+4*wma1[i]+3*wma2[i]+2*wma3[i]+wma4[i]+wma5[i]+wma6[i]+wma7[i]+wma8[i]+wma9[i])/20.0;
      rainbow_h[i]=(5*wma0h[i]+4*wma1h[i]+3*wma2h[i]+2*wma3h[i]+wma4h[i]+wma5h[i]+wma6h[i]+wma7h[i]+wma8h[i]+wma9h[i])/20.0;
      rainbow_l[i]=(5*wma0l[i]+4*wma1l[i]+3*wma2l[i]+2*wma3l[i]+wma4l[i]+wma5l[i]+wma6l[i]+wma7l[i]+wma8l[i]+wma9l[i])/20.0;

      int i2nd=i1st+InpKPeriod+1;
      if(i<=i2nd)continue;
      double dmax=0,dmin=0;

      if(InpRangeMode==CLOSE)
        {
         dmax=rainbow[ArrayMaximum(rainbow,i-(InpKPeriod-1),InpKPeriod)];
         dmin=rainbow[ArrayMinimum(rainbow,i-(InpKPeriod-1),InpKPeriod)];
        }
      else
        {
         dmax=rainbow_h[ArrayMaximum(rainbow_h,i-(InpKPeriod-1),InpKPeriod)];
         dmin=rainbow_l[ArrayMinimum(rainbow_l,i-(InpKPeriod-1),InpKPeriod)];
        }
      bufpos[i]=(rainbow[i]-dmin);
      bufsp[i]=(dmax-dmin);

      int i3rd=i2nd+InpSlowing;
      if(i<=i3rd)continue;
      double pos=0;
      double sp=0;
      for(int j=0;j<InpSlowing;j++)
        {
         pos+=bufpos[i-j];
         sp+=bufsp[i-j];
        }
      osc[i]=(sp==0)?5 :(10 *pos/sp)-5;

      //--- calculate first visible value
      int i4th=i3rd+EMAPeriod+1;
      if(i<=i4th)continue;
      double prev_val=(i==i4th)?osc[i-1]: ema0[i-1];
      ema0[i]=ExponentialMA(i,EMAPeriod,prev_val,osc);
      int i5th=i4th+EMAPeriod+1;
      if(i<=i5th)continue;
      prev_val=(i==i5th)?ema0[i-1]: ema1[i-1];
      ema1[i]=ExponentialMA(i,EMAPeriod,prev_val,osc);
      int i6th=i5th+1;
      if(i<=i6th)continue;
      sosc[i]=ema0[i]+(ema0[i]-ema1[i]);
      fish[i]=((MathExp(2*sosc[i])-1)/(MathExp(2*sosc[i])+1)+1)*50;



     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
