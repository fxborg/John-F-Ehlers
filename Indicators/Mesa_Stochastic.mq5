//+------------------------------------------------------------------+
//|  From "Mesa Stochastic" by John F. Ehlers
//|  Technical Analysis of Stocks and Commodities
//|  JANUARY 2014 TRADERS’ TIPS CODE
//| In his article in this issue, “Predictive And Successful 
//| Indicatorsauthor John Ehlers presents two new indicators: the 
//| SuperSmoother filter, which is superior to moving averages for
//| removing aliasing noise, and the MESA Stochastic oscillator, a 
//| stochastic successor that removes the effect of spectral dilation
//| through the use of a roofing filter.
//+------------------------------------------------------------------+
//|                                         Mesa_Stochastic.mq5      |
//| Mesa Stochastic                           Copyright 2016, fxborg |
//|                                   http://fxborg-labo.hateblo.jp/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, fxborg"
#property link      "http://fxborg-labo.hateblo.jp/"
#property version   "1.00"
#property indicator_separate_window
const double PI=3.14159265359;

#property indicator_minimum 0
#property indicator_maximum 1


#property indicator_level1 0.2
#property indicator_level2 0.8

#property indicator_levelcolor Silver

#property indicator_buffers 3
#property indicator_plots 1

#property indicator_type1         DRAW_LINE
#property indicator_color1        clrDodgerBlue
#property indicator_width1 2

input int InpHPF_Period=48;    // Period
input int InpSmoothing=10; //  Smoothing
input int StochPeriod= 20; // StochPeriod

                           //'Highpass filter cyclic components whose periods are shorter than 48 bars
double SQ2=sqrt(2);
double  alpha1=(cos(SQ2*PI/InpHPF_Period)+sin(SQ2*PI/InpHPF_Period)-1)/cos(SQ2 *PI/InpHPF_Period);

double HP[];
double FILT[];
double X[];
double OSC[];
int min_rates_total=10;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {

//--- 
//--- 
   SetIndexBuffer(0,OSC,INDICATOR_DATA);
   SetIndexBuffer(1,FILT,INDICATOR_DATA);
   SetIndexBuffer(2,HP,INDICATOR_DATA);
//--- 

   PlotIndexSetDouble(0,PLOT_EMPTY_VALUE,EMPTY_VALUE);
   PlotIndexSetDouble(1,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(2,PLOT_EMPTY_VALUE,0.0);
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
      a1 = MathExp( -SQ2  * PI / InpSmoothing );
      b1 = 2 * a1 * MathCos( SQ2 *PI / InpSmoothing );
      c2 = b1;
      c3 = -a1 * a1;
      c1 = 1 - c2 - c3;
      FILT[i] = c1 * ( HP[i] + HP[i-1] ) / 2 + c2 * FILT[i-1]+ c3 * FILT[i-2];
      int i2nd=i1st+StochPeriod+1;
      if(i<=i2nd)continue;

      double dmax=FILT[ArrayMaximum(FILT,i-(StochPeriod-1),StochPeriod)];
      double dmin=FILT[ArrayMinimum(FILT,i-(StochPeriod-1),StochPeriod)];


      double stoc=((dmax-dmin)==0)?0.5 :(FILT[i]-dmin)/(dmax-dmin);
      OSC[i]=c1 *(stoc+OSC[i-1])/2+c2*OSC[i-1]+c3*OSC[i-2];

     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
