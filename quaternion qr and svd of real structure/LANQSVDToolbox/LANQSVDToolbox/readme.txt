_______________________________________________________________

A toolbox for quternionic computation, based on the structure-preserving method(SPM).

_______________________________________________________________


1. Introduction
__________________

(1) There are several folders:
      BASICOPS--contains basic operator functions.
      QEIG--contains codes for computing  eigenpairs of Hermitian quaternion matrices.
      QSVD--contains codes for computing the singular value decomposition of quaternion matrices.
      LANQSVD--contains the Lanczos-based algorithm of computing partial sigular triplets of quaternion matrices. 
      DATA--contains dato of videos and face database.

(2) Demos are provided in the main folder:
    Demo1 & Demo2--indicate the Pricipal Component Analysis with applying matlab functions: svdQ and lansvdQ.
    Demo3        --indicate the Color Face Recognition with applying matlab functions: eigQ and lansvdQ.
    Demo4 & Demo5--indicate the  Color Video Compression with applying matlab functions: eigQ and lansvdQ.

 These demoes are selected from the following paper:
 Z. Jia, M. K. Ng, and G. -J. Song,``Lanczos Method for Large-Scale
 Quaternion Singular Value Decomposition'',preprint.               
     

2. How to use
_________________

Any quaternion matrix, A=A0+A1i+A2j+A3k, is represented as A=[A0,A2,A1,A3]. It is also true for quaternion scalars and vectors. For instance, the digital color image, I=(R,G,B), in quaternion matrix form, I=Ri+Gj+Bk can be  represented as  I=[0,R,G,B].

Before using this toolbox, add all folders and files into the Matlab path. 

Please run Demo1.m for introduction.  



3. Contact information
_________________________

  If there is any suggestion or comment, please feel free to contact the following authors:
  
	Zhigang Jia:  School of Mathematics and Statistics, Jiangsu Normal University,
                         Xuzhou, China (zhgjia@jsnu.edu.cn) 

	Michael K. Ng: Centre for Mathematical Imaging and Vision and Department of  
                        Mathematics, Hong Kong Baptist University (mng@math.hkbu.edu.hk)

	

4. Copyright
________________

  This work is offered without any warranty either expressed or implied; without even the 
implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE!  

  This is a freeware and can be freely used, distributed, and modified. 



5. Reference:
________________

[1] Z. Jia, M. Wei, and S. Ling. ''A New Structure-Preserving Method for
  Quaternion Hermitian Eigenvalue Problems''. J. Comput. Appl. Math.,
  239:12-24,  2013. 

[2] Z. Jia, M. Wei, M. Zhao and Y. Chen
  ``A new real structure-preserving quaternion QR algorithm''. J. Comput.
  Appl. Math., 343:26-48, 2018.

[3] Z. Jia, M. K. Ng, and G. -J. Song,``A Quaternion Framework for Robust Color Images 
 Completion'',preprint.

[4] Z. Jia, M. K. Ng, and G. -J. Song,``Lanczos Method for Large-Scale
 Quaternion Singular Value Decomposition'',preprint.



