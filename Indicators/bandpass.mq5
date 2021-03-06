//+------------------------------------------------------------------+
//|                                                bandpass.mq5      |
//| bandpass                                  Copyright 2016, fxborg |
//|                                   http://fxborg-labo.hateblo.jp/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, fxborg"
#property link      "http://fxborg-labo.hateblo.jp/"
#property version   "1.00"
#include <MovingAverages.mqh>
#property indicator_separate_window
const double PI=3.14159265359;

#property indicator_levelcolor Silver

#property indicator_buffers 125
#property indicator_plots 25

#property indicator_type1         DRAW_COLOR_ARROW
#property indicator_width1 1
#property indicator_type2         DRAW_COLOR_ARROW
#property indicator_width2 1
#property indicator_type3         DRAW_COLOR_ARROW
#property indicator_width3 1
#property indicator_type4         DRAW_COLOR_ARROW
#property indicator_width4 1
#property indicator_type5         DRAW_COLOR_ARROW
#property indicator_width5 1
#property indicator_type6         DRAW_COLOR_ARROW
#property indicator_width6 1
#property indicator_type7         DRAW_COLOR_ARROW
#property indicator_width7 1
#property indicator_type8         DRAW_COLOR_ARROW
#property indicator_width8 1
#property indicator_type9         DRAW_COLOR_ARROW
#property indicator_width9 1
#property indicator_type10       DRAW_COLOR_ARROW
#property indicator_width10 1
#property indicator_type11         DRAW_COLOR_ARROW
#property indicator_width11 1
#property indicator_type12         DRAW_COLOR_ARROW
#property indicator_width12 1
#property indicator_type13         DRAW_COLOR_ARROW
#property indicator_width13 1
#property indicator_type14         DRAW_COLOR_ARROW
#property indicator_width14 1
#property indicator_type15         DRAW_COLOR_ARROW
#property indicator_width15 1
#property indicator_type16         DRAW_COLOR_ARROW
#property indicator_width16 1
#property indicator_type17         DRAW_COLOR_ARROW
#property indicator_width17 1
#property indicator_type18         DRAW_COLOR_ARROW
#property indicator_width18 1
#property indicator_type19         DRAW_COLOR_ARROW
#property indicator_width19 1
#property indicator_type20       DRAW_COLOR_ARROW
#property indicator_width20 1
#property indicator_type21         DRAW_COLOR_ARROW
#property indicator_width21 1
#property indicator_type22         DRAW_COLOR_ARROW
#property indicator_width22 1
#property indicator_type23         DRAW_COLOR_ARROW
#property indicator_width23 1
#property indicator_type24         DRAW_COLOR_ARROW
#property indicator_width24 1
#property indicator_type25         DRAW_COLOR_ARROW
#property indicator_width25 1
input int InpPeriod=60; //Period

input double InpDelta=0.5;    // Delta
input double InpFraction=0.1;   //fraction

double BP1[],BP2[],BP3[],BP4[],BP5[],BP6[],BP7[],BP8[],BP9[],BP10[],
BP11[],BP12[],BP13[],BP14[],BP15[],BP16[],BP17[],BP18[],BP19[],BP20[],
BP21[],BP22[],BP23[],BP24[],BP25[];

double PEK1[],PEK2[],PEK3[],PEK4[],PEK5[],PEK6[],PEK7[],PEK8[],PEK9[],PEK10[],
PEK11[],PEK12[],PEK13[],PEK14[],PEK15[],PEK16[],PEK17[],PEK18[],PEK19[],PEK20[],
PEK21[],PEK22[],PEK23[],PEK24[],PEK25[];

double VLY1[],VLY2[],VLY3[],VLY4[],VLY5[],VLY6[],VLY7[],VLY8[],VLY9[],VLY10[],
VLY11[],VLY12[],VLY13[],VLY14[],VLY15[],VLY16[],VLY17[],VLY18[],VLY19[],VLY20[],
VLY21[],VLY22[],VLY23[],VLY24[],VLY25[];

double MAP1[],MAP2[],MAP3[],MAP4[],MAP5[],MAP6[],MAP7[],MAP8[],MAP9[],MAP10[],
MAP11[],MAP12[],MAP13[],MAP14[],MAP15[],MAP16[],MAP17[],MAP18[],MAP19[],MAP20[],
MAP21[],MAP22[],MAP23[],MAP24[],MAP25[];

double CLR1[],CLR2[],CLR3[],CLR4[],CLR5[],CLR6[],CLR7[],CLR8[],CLR9[],CLR10[],
CLR11[],CLR12[],CLR13[],CLR14[],CLR15[],CLR16[],CLR17[],CLR18[],CLR19[],CLR20[],
CLR21[],CLR22[],CLR23[],CLR24[],CLR25[];

int min_rates_total=10;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   int i=0;
//--- 
//--- 
   SetIndexBuffer(i++,MAP1,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR1,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP2,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR2,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP3,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR3,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP4,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR4,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP5,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR5,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP6,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR6,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP7,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR7,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP8,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR8,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP9,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR9,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP10,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR10,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP11,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR11,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP12,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR12,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP13,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR13,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP14,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR14,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP15,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR15,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP16,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR16,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP17,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR17,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP18,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR18,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP19,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR19,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP20,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR20,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP21,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR21,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP22,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR22,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP23,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR23,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP24,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR24,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(i++,MAP25,INDICATOR_DATA);
   SetIndexBuffer(i++,CLR25,INDICATOR_COLOR_INDEX);
//--- 
   SetIndexBuffer(i++,BP1,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP2,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP3,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP4,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP5,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP6,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP7,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP8,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP9,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP10,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP11,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP12,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP13,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP14,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP15,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP16,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP17,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP18,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP19,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP20,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP21,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP22,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP23,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP24,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,BP25,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK1,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK2,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK3,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK4,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK5,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK6,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK7,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK8,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK9,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK10,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK11,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK12,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK13,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK14,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK15,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK16,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK17,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK18,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK19,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK20,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK21,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK22,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK23,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK24,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,PEK25,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY1,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY2,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY3,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY4,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY5,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY6,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY7,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY8,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY9,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY10,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY11,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY12,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY13,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY14,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY15,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY16,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY17,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY18,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY19,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY20,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY21,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY22,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY23,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY24,INDICATOR_CALCULATIONS);
   SetIndexBuffer(i++,VLY25,INDICATOR_CALCULATIONS);
//--- 

   for(i=0;i<=24;i++)
     {
      PlotIndexSetInteger(i,PLOT_ARROW,110);//158 //167
      PlotIndexSetDouble(i,PLOT_EMPTY_VALUE,12);
      PlotIndexSetInteger(i,PLOT_DRAW_BEGIN,min_rates_total);
      setPlotColor(i);

     }

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
   if(rates_total<=min_rates_total) return(0);
//---
   int begin_pos=min_rates_total;

   first=begin_pos;
   if(first+1<prev_calculated) first=prev_calculated-2;

//---
   for(i=first; i<rates_total && !IsStopped(); i++)
     {

      bandpass(BP1,high,low,12,i);  bandpass(BP2,high,low,14,i); bandpass(BP3,high,low,16,i); bandpass(BP4,high,low,18,i); bandpass(BP5,high,low,20,i);
      bandpass(BP6,high,low,22,i);  bandpass(BP7,high,low,24,i); bandpass(BP8,high,low,26,i); bandpass(BP9,high,low,28,i); bandpass(BP10,high,low,30,i);
      bandpass(BP11,high,low,32,i);  bandpass(BP12,high,low,34,i); bandpass(BP13,high,low,36,i); bandpass(BP14,high,low,38,i); bandpass(BP15,high,low,40,i);
      bandpass(BP16,high,low,42,i);  bandpass(BP17,high,low,44,i); bandpass(BP18,high,low,46,i); bandpass(BP19,high,low,48,i); bandpass(BP20,high,low,50,i);
      bandpass(BP21,high,low,52,i);  bandpass(BP22,high,low,54,i); bandpass(BP23,high,low,56,i); bandpass(BP24,high,low,58,i); bandpass(BP25,high,low,60,i);
      int i1st=begin_pos+3;
      if(i<=i1st)continue;
      peak_valley(PEK1,VLY1,BP1,i);  peak_valley(PEK2,VLY2,BP2,i);  peak_valley(PEK3,VLY3,BP3,i);  peak_valley(PEK4,VLY4,BP4,i);  peak_valley(PEK5,VLY5,BP5,i);
      peak_valley(PEK6,VLY6,BP6,i);  peak_valley(PEK7,VLY7,BP7,i);  peak_valley(PEK8,VLY8,BP8,i);  peak_valley(PEK9,VLY9,BP9,i);  peak_valley(PEK10,VLY10,BP10,i);
      peak_valley(PEK11,VLY11,BP11,i);  peak_valley(PEK12,VLY12,BP12,i);  peak_valley(PEK13,VLY13,BP13,i);  peak_valley(PEK14,VLY14,BP14,i);  peak_valley(PEK15,VLY15,BP15,i);
      peak_valley(PEK16,VLY16,BP16,i);  peak_valley(PEK17,VLY17,BP17,i);  peak_valley(PEK18,VLY18,BP18,i);  peak_valley(PEK19,VLY19,BP19,i);  peak_valley(PEK20,VLY20,BP20,i);
      peak_valley(PEK21,VLY21,BP21,i);  peak_valley(PEK22,VLY22,BP22,i);  peak_valley(PEK23,VLY23,BP23,i);  peak_valley(PEK24,VLY24,BP24,i);  peak_valley(PEK25,VLY25,BP25,i);
      int i2nd=i1st+60*2+1;
      if(i<=i2nd)continue;
      set_color(CLR1,PEK1,VLY1,BP1,i); set_color(CLR2,PEK2,VLY2,BP2,i); set_color(CLR3,PEK3,VLY3,BP3,i); set_color(CLR4,PEK4,VLY4,BP4,i); set_color(CLR5,PEK5,VLY5,BP5,i);
      set_color(CLR6,PEK6,VLY6,BP6,i); set_color(CLR7,PEK7,VLY7,BP7,i); set_color(CLR8,PEK8,VLY8,BP8,i); set_color(CLR9,PEK9,VLY9,BP9,i); set_color(CLR10,PEK10,VLY10,BP10,i);
      set_color(CLR11,PEK11,VLY11,BP11,i); set_color(CLR12,PEK12,VLY12,BP12,i); set_color(CLR13,PEK13,VLY13,BP13,i); set_color(CLR14,PEK14,VLY14,BP14,i); set_color(CLR15,PEK15,VLY15,BP15,i);
      set_color(CLR16,PEK16,VLY16,BP16,i); set_color(CLR17,PEK17,VLY17,BP17,i); set_color(CLR18,PEK18,VLY18,BP18,i); set_color(CLR19,PEK19,VLY19,BP19,i); set_color(CLR20,PEK20,VLY20,BP20,i);
      set_color(CLR21,PEK21,VLY21,BP21,i); set_color(CLR22,PEK22,VLY22,BP22,i); set_color(CLR23,PEK23,VLY23,BP23,i); set_color(CLR24,PEK24,VLY24,BP24,i); set_color(CLR25,PEK25,VLY25,BP25,i);

      MAP1[i]=12;
      MAP2[i]=14;
      MAP3[i]=16;
      MAP4[i]=18;
      MAP5[i]=20;
      MAP6[i]=22;
      MAP7[i]=24;
      MAP8[i]=26;
      MAP9[i]=28;
      MAP10[i]=30;
      MAP11[i]=32;
      MAP12[i]=34;
      MAP13[i]=36;
      MAP14[i]=38;
      MAP15[i]=40;
      MAP16[i]=42;
      MAP17[i]=44;
      MAP18[i]=46;
      MAP19[i]=48;
      MAP20[i]=50;
      MAP21[i]=52;
      MAP22[i]=54;
      MAP23[i]=56;
      MAP24[i]=58;
      MAP25[i]=60;

     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
void bandpass(double  &res[],const double   &h[],const double  &l[],const int period,int i)
  {

   double beta=cos(2*PI/period);
   double gamma = 1/ cos(4 * PI * InpDelta / period);
   double alpha = gamma - sqrt(gamma * gamma - 1.0);
   double p0,p1,p2;
   p0=(h[i]-l[i])/2;
   p1=(h[i-1]-l[i-1])/2;
   p2=(h[i-2]-l[i-2])/2;
   double res1=p0-p2;
   double res2=p0-p2;
   if(res[i-1]!=EMPTY_VALUE)res1=res[i-1];
   if(res[i-2]!=EMPTY_VALUE)res2=res[i-2];

   res[i]=0.5 *(1-alpha) *(p0-p2)+beta *(1+alpha)*res1-alpha*res2;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void peak_valley(double  &PEK[],double  &VLY[],double  &BP[],const int i)
  {
   PEK[i]=(BP[i]<BP[i-1] && BP[i-1]>BP[i-2])?BP[i-1]:PEK[i-1];
   VLY[i]=(BP[i]>BP[i-1] && BP[i-1]<BP[i-2])?BP[i-1]:VLY[i-1];
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void set_color(double  &CLR[],const double  &PEK[],const double  &VLY[],const double  &BP[],const int i)
  {
   double mean = SimpleMA(i,InpPeriod,BP);
   double apek = SimpleMA(i,InpPeriod,PEK);
   double avly = SimpleMA(i,InpPeriod,VLY);
   double amp=MathMax(_Point,(apek-avly));

   double ratio=mean/(InpFraction*amp);
   ratio=MathMin(1,MathMax(-1,ratio));
   CLR[i]=12+int(11*ratio);
  }
//+------------------------------------------------------------------+

void setPlotColor(int plot)
  {
   PlotIndexSetInteger(plot,PLOT_COLOR_INDEXES,25); //Set number of colors 
   int i=12;
   for(int n=0;n<=12;n++)
     {
      PlotIndexSetInteger(plot,PLOT_LINE_COLOR,n,toRGB(200-i*10,255,0));
      i--;
     }

   PlotIndexSetInteger(plot,PLOT_LINE_COLOR,13,toRGB(200,200,0));
   i=0;
   for(int n=14;n<=24;n++)
     {
      PlotIndexSetInteger(plot,PLOT_LINE_COLOR,n,toRGB(255,200-i*10,0));

      i++;
     }
  }
//+------------------------------------------------------------------+
color toRGB(int r,int g,int b)
  {
   r=MathMin(255,MathMax(0,r));
   g=MathMin(255,MathMax(0,g));
   b=MathMin(255,MathMax(0,b));
   return StringToColor(IntegerToString(r)+","+IntegerToString(g)+","+IntegerToString(b));
  }
//+------------------------------------------------------------------+
