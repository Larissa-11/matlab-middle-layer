/*   File: atphyslib.c
     Common physics functions for Accelerator Toolbox
     A.Terebilo   10/28/04

*/
	
#include "mex.h"
#include<math.h>


void edge(double* r, double inv_rho, double edge_angle)
{	/* Edge focusing in dipoles with hard-edge field */
    double psi = inv_rho*tan(edge_angle)/(1+r[4]);    /* /(1+r[4]) term included acoording to L.Nadolsky sudgestion*/

    r[1]+=r[0]*psi;
	r[3]-=r[2]*psi;
}

void edge_V(double* r, double inv_rho_x, double inv_rho_y, double edge_angle_x, double edge_angle_y)
{	/* Edge focusing in dipoles with hard-edge field */
    double psi_x = inv_rho_x*tan(edge_angle_x)/(1+r[4]); /* /(1+r[4]) term included acoording to L.Nadolsky sudgestion*/
    double psi_y = inv_rho_y*tan(edge_angle_y)/(1+r[4]); /* /(1+r[4]) term included acoording to L.Nadolsky sudgestion*/
 
    r[1]+=r[0]*(psi_x+psi_y);
	r[3]-=r[2]*(psi_x+psi_y);
}

void edge_fringe(double* r, double inv_rho, double edge_angle, double fint, double gap)
{   /* Edge focusing in dipoles with fringe field */
    double fx = inv_rho*tan(edge_angle)/(1+r[4]);  /* /(1+r[4]) term included acoording to L.Nadolsky sudgestion*/
    double psi_bar = edge_angle-inv_rho*gap*fint*(1+sin(edge_angle)*sin(edge_angle))/cos(edge_angle)/(1+r[4]);
    double fy = inv_rho*tan(psi_bar)/(1+r[4]);  /* /(1+r[4]) term included acoording to L.Nadolsky sudgestion*/
    r[1]+=r[0]*fx;
    r[3]-=r[2]*fy;    
}

void AT_H_Full_Bend_y_Drift(double* r, double L, double irho)
{	double pz0 = sqrt(1.0+r[4]*r[4]+2*r[4]-r[1]*r[1]-r[3]*r[3]);
    double pn0 = sqrt(1.0+r[4]*r[4]+2*r[4]-r[3]*r[3]);
    double c=cos(L*irho);
    double dpz,pzf,as0,asf,s=sin(L*irho);
    as0=asin(r[1]/pn0);
    /*printf(" A: x: %1.10f px: %1.10f  y: %1.10f py: %1.10f  d: %1.10f pz: %1.10f\n",r[0],r[1],r[2],r[3],r[4],r[5]);*/
    dpz=-s*r[1]+c*(pz0-(1+irho*r[0]));
    r[1]=c*r[1]+s*(pz0-(1+irho*r[0]));
    asf=asin(r[1]/pn0);
    pzf=sqrt(1.0+r[4]*r[4]+2*r[4]-r[1]*r[1]-r[3]*r[3]);
    r[0]=(pzf-dpz-1)/irho;
    r[2]+=r[3]*(L+(as0-asf)/irho);
    r[5]+=(1+r[4])*(L+(as0-asf)/irho)-L;
    /*printf(" A: x: %1.10f px: %1.10f  y: %1.10f py: %1.10f  d: %1.10f pz: %1.10f\n",r[0],r[1],r[2],r[3],r[4],r[5]);*/
}


        
void AT_H_Full_Drift(double* r, double L)
/*   Input parameter L is the physical length
     1/(1+delta) normalization is done internally
*/
{	double NormL = L/sqrt((1.0+r[4]*r[4]+2*r[4]-r[1]*r[1]-r[3]*r[3])); 
	r[0]+= NormL*r[1]; 
	r[2]+= NormL*r[3];
	r[5]+= NormL*(1.0+r[4])-L;
}

void Rotation_y(double* r, double phi)
/*   Roration arround the  y axis
*/
{	double inv_pz = 1.0/sqrt((1.0+r[4]*r[4]+2*r[4]-r[1]*r[1]-r[3]*r[3]));
    double c=cos(phi);
    double t=tan(phi);
    double norm = 1.0/(1.0-r[1]*t*inv_pz);
    double x0=r[0];
	r[0]= x0/c*norm;
    r[1]=c*(r[1]+t/inv_pz);
    r[2]+=x0*r[3]*inv_pz*t*norm;
    r[5]+=x0*(1.0+r[4])*inv_pz*t*norm;
}


void Ideal_Wedge(double* r, double phi, double b1)
{	double pz0 = sqrt(1.0+r[4]*r[4]+2*r[4]-r[1]*r[1]-r[3]*r[3]);
    double pn0 = sqrt(1.0+r[4]*r[4]+2*r[4]-r[3]*r[3]);
    double c=cos(phi);
    double x0,px0,dpz,pzf,as0,asf,s=sin(phi);
    px0=r[1];x0=r[0];
    r[1]=c*px0+s*(pz0-b1*x0);
    pzf=sqrt(1.0+r[4]*r[4]+2*r[4]-r[1]*r[1]-r[3]*r[3]);
    r[0]=x0*c+(2*x0*px0*s*c+s*s*(2*x0*pz0-b1*x0*x0))/(pzf+pz0*c-px0*s);
    as0=asin(px0/pn0);
    asf=asin(r[1]/pn0);
    r[2]+=r[3]*(phi+(as0-asf))/b1;
    r[5]+=(1+r[4])*(phi+(as0-asf))/b1;
}

void BendFringe(double* r, double b0,double sign,double step)
/* E.Forest book pg 383 formula 13.13
 limit for the hard edge dipole fringe field
 */
{
    double px,y,py,d,c,yf,yf0;
    double d2 =1.0+2.0*r[4]+r[4]*r[4];
    double pz = sqrt(d2-r[1]*r[1]-r[3]*r[3]);
    double pn2 = (d2-r[1]*r[1]);
    px=r[1];y=r[2];py=r[3];d=r[4];
    c=sign*step*(b0*px*py)/(pn2*pz);
    if (fabs(2*y*c)>1.0e-6) {
        yf=2*y/(sqrt(1+2*y*c)+1);
    }
    else {
        yf=y*(1.0-c*y/2+c*c*y*y/2-5*c*c*c*y*y*y/8);
    }
    r[0]+=sign*step*b0*yf*yf*(d2-(d2+px*px)*py*py/pn2)/pz/pn2/2;
    r[2]=yf;
    r[3]-=sign*step*b0*yf*px*pz/pn2;
    r[5]+=sign*step*b0*yf*yf*(1+d)*px*(pz*pz-py*py)/pn2/pz/pn2/2;
}


void BendFringe_FINT(double* r, double b0,double sign,double fint,double gap,double step)
/* E.Forest book pg 383 formula 13.13
 limit for the hard edge dipole fringe field
 */
{
    double px,y,py,d,yf,yf0,K,dfpy,dfd,dfpx,f,px2,py2,px4,py4,pz2,pz5,pz7,d4;
    double d2 =1.0+2.0*r[4]+r[4]*r[4];
    double pz = sqrt(d2-r[1]*r[1]-r[3]*r[3]);
    double pn2 = (d2-r[1]*r[1]);
    
    K=sign*gap*fint*b0;  /*sign is added here to avoid the sign dependence of this term*/
    px=r[1];y=r[2];py=r[3];d=r[4];
    d4=d2*d2;
    px2=px*px;
    py2=py*py;
    px4=px2*px2;
    py4=py2*py2;
    pz2=pz*pz;
    pz5=pz2*pz2*pz;
    pz7=pz5*pz2;
    f=step*sign*b0*(px*pz/pn2-K*(d4+py4-px4-2*py2*d2+px2*py2)/pz5);
   
    dfpx=step*sign*b0*((d2-(d2+px2)*py2/pn2)/pz/pn2-K*px*(5*d4+4*d2*px2+3*py4+px4-8*py2*d2-px2*py2)/pz7);
    dfpy=step*sign*b0*py*(-px/(pn2*pz)-K*(d4+6*d2*px2+py4+3*px4-2*py2*d2-px2*py2)/pz7);
    dfd=step*sign*b0*(1+d)*(-px*(pz2-py2)/pn2/pz/pn2-K*(-d4-4*d2*px2-py4-5*px4+2*py2*d2-px2*py2)/pz7);
    if (fabs(2*y*dfpy)>1.0e-6) {
        yf=2*y/(sqrt(1+2*y*dfpy)+1);
    }
    else {
        yf=y*(1.0-dfpy*y/2+dfpy*dfpy*y*y/2-5*dfpy*dfpy*dfpy*y*y*y/8);
    }
    r[0]+=yf*yf*dfpx/2;
    r[2]=yf;
    r[3]-=yf*f;
    r[5]-=yf*yf*dfd/2;
}

void QuadFringe_step(double* r, double b2,double sign,double step)
/* Lee-Whiting limit for the hard edge quadrupole fringe field*/
{
    double x,px,y,py,l,d,x2,y2,x3,y3,sign_norm;
    x=r[0];px=r[1];y=r[2];py=r[3];d=r[4];l=r[5];
    x2=x*x;
    x3=x2*x;
    y2=y*y;
    y3=y2*y;
    sign_norm=sign*step/(1+d);
    r[0]=x+sign_norm*b2*(x3+3*y2*x)/12.0;
    r[1]=px+sign_norm*b2*(2*x*y*py-x2*px-y2*px)/4.0;
    r[2]=y-sign_norm*b2*(y3+3*y*x2)/12.0;
    r[3]=py-sign_norm*b2*(2*y*x*px-y2*py-x2*py)/4.0;
    r[5]=l-sign_norm*b2*(y3*py-x3*px+3*x2*y*py-3*y2*x*px)/12.0/(1+d);
}

void QuadFringe(double* r, double b2,double sign)
/* Lee-Whiting limit for the hard edge quadrupole fringe field*/
{
    double x,px,y,py,l,d,x2,y2,x3,y3,sign_norm;
    x=r[0];px=r[1];y=r[2];py=r[3];d=r[4];l=r[5];
    x2=x*x;
    x3=x2*x;
    y2=y*y;
    y3=y2*y;
    sign_norm=sign/(1+d);
    r[0]=x+sign_norm*b2*(x3+3*y2*x)/12.0;
    r[1]=px+sign_norm*b2*(2*x*y*py-x2*px-y2*px)/4.0;
    r[2]=y-sign_norm*b2*(y3+3*y*x2)/12.0;
    r[3]=py-sign_norm*b2*(2*y*x*px-y2*py-x2*py)/4.0;
    r[5]=l-sign_norm*b2*(y3*py-x3*px+3*x2*y*py-3*y2*x*px)/12.0/(1+d);
}

