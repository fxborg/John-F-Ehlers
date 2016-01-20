//+------------------------------------------------------------------+
//|  From "The Quotient Transform" by John F. Ehlers
//|  Technical Analysis of Stocks and Commodities
//|  August, 2014
//+------------------------------------------------------------------+
//|                                       The_Quotient_Transform.mq5 |
//| The Quotient Transform                    Copyright 2016, fxborg |
//|                                   http://fxborg-labo.hateblo.jp/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, fxborg"
#property link      "http://fxborg-labo.hateblo.jp/"
#property version   "1.00"
#property indicator_separate_window
const double PI=3.14159265359;

#property indicator_levelcolor Silver

#property indicator_buffers 8
#property indicator_plots 4

#property indicator_type1         DRAW_LINE
#property indicator_color1        clrDodgerBlue
#property indicator_width1 2
#property indicator_type2         DRAW_LINE
#property indicator_color2        clrCyan
#property indicator_width2 1
#property indicator_style2        STYLE_DOT
#property indicator_type3         DRAW_LINE
#property indicator_color3        clrRed
#property indicator_width3 2
#property indicator_type4         DRAW_LINE
#property indicator_color4        clrOrange
#property indicator_width4 1
#property indicator_style4        STYLE_DOT

input int InpLPPeriod=30;  // LP Period
input double InpK1L=0.85;  // K1(Long)
input double InpK2L=0.4;  // K2(Long)
input double InpK1S=-0.85;  // K1(Short)
input double InpK2S=-0.4;  // K2(Short)

double alpha1=(MathCos(.707*2*PI/100)+MathSin(.707*2*PI/100)-1)/MathCos(.707*2*PI/100);

double HP[];
double FILT[];
double PEAK[];
double X[];
double QT_Long1[];
double QT_Long2[];
double QT_Short1[];
double QT_Short2[];
int min_rates_total=10;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {

//--- 
//--- 
   SetIndexBuffer(0,QT_Long1,INDICATOR_DATA);
   SetIndexBuffer(1,QT_Long2,INDICATOR_DATA);
   SetIndexBuffer(2,QT_Short1,INDICATOR_DATA);
   SetIndexBuffer(3,QT_Short2,INDICATOR_DATA);
   SetIndexBuffer(4,X,INDICATOR_CALCULATIONS);
   SetIndexBuffer(5,HP,INDICATOR_CALCULATIONS);
   SetIndexBuffer(6,FILT,INDICATOR_CALCULATIONS);
   SetIndexBuffer(7,PEAK,INDICATOR_CALCULATIONS);
//--- 

   PlotIndexSetDouble(0,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(1,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(2,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(3,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(4,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(5,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(6,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(7,PLOT_EMPTY_VALUE,0.0);
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
      double hp1=(HP[i-1]==0)?(1-alpha1)*(close[i-1]-2*close[i-2]+close[i-3]):HP[i-1];
      double hp2=(HP[i-2]==0)?(1-alpha1)*(close[i-2]-2*close[i-3]+close[i-4]):HP[i-2];

      // Highpass filter cyclic components
      HP[i]=(1-alpha1/2)*(1-alpha1/2)*(close[i]-2*close[i-1]+close[i-2])
            +2 *(1-alpha1)*hp1 -(1-alpha1) *(1-alpha1)*hp2;

      int i1st=begin_pos+2;
      if(i<=i1st)continue;

      double a1,b1,c2,c3,c1;

      // SuperSmoother Filter

      a1 = MathExp( -1.414 * PI / InpLPPeriod );
      b1 = 2 * a1 * MathCos( 1.414*PI / InpLPPeriod );
      c2 = b1;
      c3 = -a1 * a1;
      c1 = 1 - c2 - c3;
      FILT[i] = c1 * ( HP[i] + HP[i-1] ) / 2 + c2 * FILT[i-1]+ c3 * FILT[i-2];
      int i2nd=i1st+2;
      if(i<=i2nd)continue;
      PEAK[i]=0.991*PEAK[i-1];
      if(MathAbs(FILT[i])>PEAK[i]) PEAK[i]=MathAbs(FILT[i]);

      // Normalized Roofing Filter
      X[i]=(PEAK[i]!=0)? FILT[i]/PEAK[i]:0;

      QT_Long1[i] = (X[i] + InpK1L) / (InpK1L * X[i] + 1);
      QT_Long2[i] = (X[i] + InpK2L) / (InpK2L * X[i] + 1);

      QT_Short1[i] = (X[i] + InpK1S) / (InpK1S * X[i] + 1);
      QT_Short2[i] = (X[i] + InpK2S) / (InpK2S * X[i] + 1);




     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
