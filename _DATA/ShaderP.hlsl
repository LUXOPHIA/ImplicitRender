//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdFloat

struct TdFloat
{
    float o;
    float d;
};

inline TdFloat newTdFloat( float o_, float d_ )
{
    TdFloat Result;

    Result.o = o_;
    Result.d = d_;

    return Result;
}

inline TdFloat newTdFloat( float o_ )
{
    return newTdFloat( o_, 0 );
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdFloat3

struct TdFloat3
{
    TdFloat x;
    TdFloat y;
    TdFloat z;
};

inline TdFloat3 newTdFloat3( float X_, float Y_, float Z_ )
{
    TdFloat3 Result;

    Result.x = newTdFloat( X_, 0 );
    Result.y = newTdFloat( Y_, 0 );
    Result.z = newTdFloat( Z_, 0 );

    return Result;
}

inline TdFloat3 newTdFloat3( float3 V_ )
{
    return newTdFloat3( V_.x, V_.y, V_.z );
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRay

struct TRay
{
    float3 Pos;
    float3 Vec;
};

inline TRay newTRay( float3 Pos_, float3 Vec_ )
{
    TRay Result;

    Result.Pos = Pos_;
    Result.Vec = Vec_;

    return Result;
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdRay

struct TdRay
{
    TdFloat3 Pos;
    TdFloat3 Vec;
};

inline TdRay newTdRay( TRay Ray_ )
{
    TdRay Result;

    Result.Pos = newTdFloat3( Ray_.Pos );
    Result.Vec = newTdFloat3( Ray_.Vec );

    return Result;
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdComplex

struct TdComplex
{
    TdFloat R;
    TdFloat I;
};

inline TdComplex newTdComplex( TdFloat R_, TdFloat I_ )
{
    TdComplex Result;

    Result.R = R_;
    Result.I = I_;

    return Result;
}

inline TdComplex newTdComplex( float R_, float I_ )
{
    return newTdComplex( newTdFloat( R_ ), newTdFloat( I_ ) );
}

inline TdComplex newTdComplex( float R_ )
{
    return newTdComplex( R_, 0 );
}

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

static const float PI        = 3.14159265;
static const float FLOAT_MAX = 3.402823466E+38;

SamplerState _Sampler {};

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

inline int3 Sign( float3 V_ )
{
    int3 Result;

    Result.x = sign( V_.x );
    Result.y = sign( V_.y );
    Result.z = sign( V_.z );

    return Result;
}

inline float3 Abs( float3 V_ )
{
    float3 Result;

    Result.x = abs( V_.x );
    Result.y = abs( V_.y );
    Result.z = abs( V_.z );

    return Result;
}

inline float3 Floor( float3 V_ )
{
    float3 Result;

    Result.x = floor( V_.x );
    Result.y = floor( V_.y );
    Result.z = floor( V_.z );

    return Result;
}

inline float Pow2( float X_ )
{
    return X_ * X_;
}

inline float3 Pow2( float3 V_ )
{
    float3 Result;

    Result.x = Pow2( V_.x );
    Result.y = Pow2( V_.y );
    Result.z = Pow2( V_.z );

    return Result;
}

inline float Min( float A_, float B_, float C_ )
{
    return min( min( A_, B_ ), C_ );
}

inline int MinI( float A_, float B_, float C_ )
{
    if ( A_ <= B_ )
    {
        if ( A_ <= C_ ) return 0;
                   else return 2;
    }
    else
    {
        if ( B_ <= C_ ) return 1;
                   else return 2;
    }
}

inline int MinI( float3 V_ )
{
    return MinI( V_.x, V_.y, V_.z );
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdFloat

///////////////////////////////////////////////////////////////////////// 演算子

inline TdFloat Add( TdFloat A_, TdFloat B_ )
{
    TdFloat Result;

    Result.o = A_.o + B_.o;
    Result.d = A_.d + B_.d;

    return Result;
}

inline TdFloat Add( float A_, TdFloat B_ )
{
    TdFloat Result;

    Result.o = A_ + B_.o;
    Result.d =      B_.d;

    return Result;
}

inline TdFloat Add( TdFloat A_, float B_ )
{
    TdFloat Result;

    Result.o = A_.o + B_;
    Result.d = A_.d     ;

    return Result;
}

//------------------------------------------------------------------------------

inline TdFloat Sub( TdFloat A_, float B_ )
{
    TdFloat Result;

    Result.o = A_.o - B_;
    Result.d = A_.d     ;

    return Result;
}

inline TdFloat Sub( float A_, TdFloat B_ )
{
    TdFloat Result;

    Result.o = A_ - B_.o;
    Result.d =     -B_.d;

    return Result;
}

inline TdFloat Sub( TdFloat A_, TdFloat B_ )
{
    TdFloat Result;

    Result.o = A_.o - B_.o;
    Result.d = A_.d - B_.d;

    return Result;
}

//------------------------------------------------------------------------------

inline TdFloat Mul( TdFloat A_, TdFloat B_ )
{
    TdFloat Result;

    Result.o = A_.o * B_.o;
    Result.d = A_.d * B_.o + A_.o * B_.d;

    return Result;
}

inline TdFloat Mul( float A_, TdFloat B_ )
{
    TdFloat Result;

    Result.o = A_ * B_.o;
    Result.d = A_ * B_.d;

    return Result;
}

inline TdFloat Mul( TdFloat A_, float B_ )
{
    TdFloat Result;

    Result.o = A_.o * B_;
    Result.d = A_.d * B_;

    return Result;
}

//------------------------------------------------------------------------------

inline TdFloat Div( TdFloat A_, TdFloat B_ )
{
    TdFloat Result;

    Result.o =                 A_.o          /       B_.o  ;
    Result.d = ( A_.d * B_.o - A_.o * B_.d ) / Pow2( B_.o );

    return Result;
}

inline TdFloat Div( float A_, TdFloat B_ )
{
    TdFloat Result;

    Result.o =  A_        /       B_.o  ;
    Result.d = -A_ * B_.d / Pow2( B_.o );

    return Result;
}

inline TdFloat Div( TdFloat A_, float B_ )
{
    TdFloat Result;

    Result.o = A_.o / B_;
    Result.d = A_.d / B_;

    return Result;
}

////////////////////////////////////////////////////////////////////////////////

inline TdFloat Pow2( TdFloat A_ )
{
    TdFloat Result;

    Result.o = Pow2( A_.o );
    Result.d = 2 * A_.o * A_.d;

    return Result;
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdFloat3

///////////////////////////////////////////////////////////////////////// 演算子

inline TdFloat3 Add( TdFloat3 A_, TdFloat3 B_ )
{
    TdFloat3 Result;

    Result.x = Add( A_.x, B_.x );
    Result.y = Add( A_.y, B_.y );
    Result.z = Add( A_.z, B_.z );

    return Result;
}

inline TdFloat3 Add( float3 A_, TdFloat3 B_ )
{
    TdFloat3 Result;

    Result.x = Add( A_.x, B_.x );
    Result.y = Add( A_.y, B_.y );
    Result.z = Add( A_.z, B_.z );

    return Result;
}

inline TdFloat3 Add( TdFloat3 A_, float3 B_ )
{
    TdFloat3 Result;

    Result.x = Add( A_.x, B_.x );
    Result.y = Add( A_.y, B_.y );
    Result.z = Add( A_.z, B_.z );

    return Result;
}

//------------------------------------------------------------------------------

inline TdFloat3 Sub( TdFloat3 A_, TdFloat3 B_ )
{
    TdFloat3 Result;

    Result.x = Sub( A_.x, B_.x );
    Result.y = Sub( A_.y, B_.y );
    Result.z = Sub( A_.z, B_.z );

    return Result;
}

inline TdFloat3 Sub( float3 A_, TdFloat3 B_ )
{
    TdFloat3 Result;

    Result.x = Sub( A_.x, B_.x );
    Result.y = Sub( A_.y, B_.y );
    Result.z = Sub( A_.z, B_.z );

    return Result;
}

inline TdFloat3 Sub( TdFloat3 A_, float3 B_ )
{
    TdFloat3 Result;

    Result.x = Sub( A_.x, B_.x );
    Result.y = Sub( A_.y, B_.y );
    Result.z = Sub( A_.z, B_.z );

    return Result;
}

//------------------------------------------------------------------------------

inline TdFloat3 Mul( TdFloat3 A_, TdFloat3 B_ )
{
    TdFloat3 Result;

    Result.x = Mul( A_.x, B_.x );
    Result.y = Mul( A_.y, B_.y );
    Result.z = Mul( A_.z, B_.z );

    return Result;
}

inline TdFloat3 Mul( float3 A_, TdFloat3 B_ )
{
    TdFloat3 Result;

    Result.x = Mul( A_.x, B_.x );
    Result.y = Mul( A_.y, B_.y );
    Result.z = Mul( A_.z, B_.z );

    return Result;
}

inline TdFloat3 Mul( TdFloat3 A_, float3 B_ )
{
    TdFloat3 Result;

    Result.x = Mul( A_.x, B_.x );
    Result.y = Mul( A_.y, B_.y );
    Result.z = Mul( A_.z, B_.z );

    return Result;
}

//------------------------------------------------------------------------------

inline TdFloat3 Mul( TdFloat A_, TdFloat3 B_ )
{
    TdFloat3 Result;

    Result.x = Mul( A_, B_.x );
    Result.y = Mul( A_, B_.y );
    Result.z = Mul( A_, B_.z );

    return Result;
}

inline TdFloat3 Mul( float A_, TdFloat3 B_ )
{
    TdFloat3 Result;

    Result.x = Mul( A_, B_.x );
    Result.y = Mul( A_, B_.y );
    Result.z = Mul( A_, B_.z );

    return Result;
}

inline TdFloat3 Mul( TdFloat A_, float3 B_ )
{
    TdFloat3 Result;

    Result.x = Mul( A_, B_.x );
    Result.y = Mul( A_, B_.y );
    Result.z = Mul( A_, B_.z );

    return Result;
}

//------------------------------------------------------------------------------

inline TdFloat3 Mul( TdFloat3 A_, float B_ )
{
    TdFloat3 Result;

    Result.x = Mul( A_.x, B_ );
    Result.y = Mul( A_.y, B_ );
    Result.z = Mul( A_.z, B_ );

    return Result;
}

inline TdFloat3 Mul( float3 A_, TdFloat B_ )
{
    TdFloat3 Result;

    Result.x = Mul( A_.x, B_ );
    Result.y = Mul( A_.y, B_ );
    Result.z = Mul( A_.z, B_ );

    return Result;
}

inline TdFloat3 Mul( TdFloat3 A_, TdFloat B_ )
{
    TdFloat3 Result;

    Result.x = Mul( A_.x, B_ );
    Result.y = Mul( A_.y, B_ );
    Result.z = Mul( A_.z, B_ );

    return Result;
}

//------------------------------------------------------------------------------

inline TdFloat3 Div( TdFloat3 A_, TdFloat3 B_ )
{
    TdFloat3 Result;

    Result.x = Div( A_.x, B_.x );
    Result.y = Div( A_.y, B_.y );
    Result.z = Div( A_.z, B_.z );

    return Result;
}

inline TdFloat3 Div( float3 A_, TdFloat3 B_ )
{
    TdFloat3 Result;

    Result.x = Div( A_.x, B_.x );
    Result.y = Div( A_.y, B_.y );
    Result.z = Div( A_.z, B_.z );

    return Result;
}

inline TdFloat3 Div( TdFloat3 A_, float3 B_ )
{
    TdFloat3 Result;

    Result.x = Div( A_.x, B_.x );
    Result.y = Div( A_.y, B_.y );
    Result.z = Div( A_.z, B_.z );

    return Result;
}

//------------------------------------------------------------------------------

inline TdFloat3 Div( TdFloat3 A_, TdFloat B_ )
{
    TdFloat3 Result;

    Result.x = Div( A_.x, B_ );
    Result.y = Div( A_.y, B_ );
    Result.z = Div( A_.z, B_ );

    return Result;
}

inline TdFloat3 Div( float3 A_, TdFloat B_ )
{
    TdFloat3 Result;

    Result.x = Div( A_.x, B_ );
    Result.y = Div( A_.y, B_ );
    Result.z = Div( A_.z, B_ );

    return Result;
}

inline TdFloat3 Div( TdFloat3 A_, float B_ )
{
    TdFloat3 Result;

    Result.x = Div( A_.x, B_ );
    Result.y = Div( A_.y, B_ );
    Result.z = Div( A_.z, B_ );

    return Result;
}

////////////////////////////////////////////////////////////////////////////////

inline TdFloat Abs2( TdFloat3 A_ )
{
    return Add( Add( Pow2( A_.x ), Pow2( A_.y ) ), Pow2( A_.z ) );
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdComplex

inline TdFloat Abs2( TdComplex C_ )
{
    return Add( Pow2( C_.R ), Pow2( C_.I ) );
}

///////////////////////////////////////////////////////////////////////// 演算子

inline TdComplex Add( TdComplex A_, TdComplex B_ )
{
    TdComplex Result;

    Result.R = Add( A_.R, B_.R );
    Result.I = Add( A_.I, B_.I );

    return Result;
}

inline TdComplex Add( float A_, TdComplex B_ )
{
    return Add( newTdComplex( A_ ), B_ );
}

inline TdComplex Add( TdComplex A_, float B_ )
{
    return Add( A_, newTdComplex( B_ ) );
}

//------------------------------------------------------------------------------

inline TdComplex Sub( TdComplex A_, TdComplex B_ )
{
    TdComplex Result;

    Result.R = Sub( A_.R, B_.R );
    Result.I = Sub( A_.I, B_.I );

    return Result;
}

inline TdComplex Sub( float A_, TdComplex B_ )
{
    return Sub( newTdComplex( A_ ), B_ );
}

inline TdComplex Sub( TdComplex A_, float B_ )
{
    return Sub( A_, newTdComplex( B_ ) );
}

//------------------------------------------------------------------------------

inline TdComplex Mul( TdComplex A_, TdComplex B_ )
{
    TdComplex Result;

    Result.R = Sub( Mul( A_.R, B_.R ), Mul( A_.I, B_.I ) );
    Result.I = Add( Mul( A_.R, B_.I ), Mul( A_.I, B_.R ) );

    return Result;
}

inline TdComplex Mul( float A_, TdComplex B_ )
{
    return Mul( newTdComplex( A_ ), B_ );
}

inline TdComplex Mul( TdComplex A_, float B_ )
{
    return Mul( A_, newTdComplex( B_ ) );
}

//------------------------------------------------------------------------------

inline TdComplex Div( TdComplex A_, TdComplex B_ )
{
    TdComplex Result;

    TdFloat C = Abs2( B_ );

    Result.R = Div( Add( Mul( A_.R, B_.R ), Mul( A_.I, B_.I ) ), C );
    Result.I = Div( Sub( Mul( A_.I, B_.R ), Mul( A_.R, B_.I ) ), C );

    return Result;
}

inline TdComplex Div( float A_, TdComplex B_ )
{
    return Div( newTdComplex( A_ ), B_ );
}

inline TdComplex Div( TdComplex A_, float B_ )
{
    return Div( A_, newTdComplex( B_ ) );
}

////////////////////////////////////////////////////////////////////////////////

inline TdComplex Pow2( TdComplex C_ )
{
    return Mul( C_, C_ );
}

inline TdComplex Pow3( TdComplex C_ )
{
    return Mul( Pow2( C_ ), C_ );
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TdFloat Cos( TdFloat X_ )
{
    TdFloat Result;

    Result.o =         cos( X_.o );
    Result.d = X_.d * -sin( X_.o );

    return Result;
}

TdFloat Sin( TdFloat X_ )
{
    TdFloat Result;

    Result.o =         sin( X_.o );
    Result.d = X_.d * +cos( X_.o );

    return Result;
}

//############################################################################## ■

TdFloat WaveField( TdFloat3 P_ )
{
    return Add( Add( Sin( Add( _Phase, Mul( PI, Mul( P_.x, P_.y ) ) ) ),
                     Sin( Add( _Phase, Mul( PI, Mul( P_.y, P_.z ) ) ) ) ),
                     Sin( Add( _Phase, Mul( PI, Mul( P_.z, P_.x ) ) ) ) );
}

//------------------------------------------------------------------------------

TdFloat MathFunc( TdFloat3 P_ )
{
    float3 _Min = { -2, -2, -2 };
    float3 _Max = { +2, +2, +2 };

    TdFloat3 P = Add( Mul( P_, ( _Max - _Min ) / _Size ), _Min );

    return WaveField( P );
}

float3 MathGrad( float3 P_ )
{
    float3 Result;

    TdFloat3 P = newTdFloat3( P_ );

    P.x.d = 1;  P.y.d = 0;  P.z.d = 0;

    Result.x = MathFunc( P ).d;

    P.x.d = 0;  P.y.d = 1;  P.z.d = 0;

    Result.y = MathFunc( P ).d;

    P.x.d = 0;  P.y.d = 0;  P.z.d = 1;

    Result.z = MathFunc( P ).d;

    return Result;
}

//------------------------------------------------------------------------------

bool HitFunc( TRay R_, float T0_, float T1_, out float T_, out float3 P_ )
{
    TdFloat T;
    T.o = T0_;
    T.d = 1  ;

    [loop]
    for ( uint N = 1; N <= 64; N++ )
    {
        TdFloat3 P = Add( Mul( R_.Vec, T ), R_.Pos );

        TdFloat  F = MathFunc( P );

        if ( abs( F.o ) < 0.001 )
        {
            T_ = T.o;
            P_ = float3( P.x.o, P.y.o, P.z.o );

            return true;
        }

        T.o = T.o - F.o / F.d;

        if ( ( T.o < T0_ ) || ( T1_ < T.o ) ) return false;
    }

    return false;
}

////////////////////////////////////////////////////////////////////////////////

struct TSenderP
{
    float4 Scr :SV_Position;
    float4 Pos :TEXCOORD0  ;
};

struct TResultP
{
    float4 Col :SV_Target;
};

//------------------------------------------------------------------------------

TResultP MainP( TSenderP _Sender )
{
    uint _DivN = 128;

    TResultP Result;

    //·································

    float3 E = mul( _EyePos, _MatrixGL ).xyz;

    TRay R = newTRay( _Sender.Pos.xyz, normalize( _Sender.Pos.xyz - E ) );

    Result.Col = 0;

    float3 Tv = _Size / Abs( R.Vec );

    float3 Gd = R.Pos / _Size;

    float3 Ts;

    if ( isinf( Tv.x ) ) Ts.x = FLOAT_MAX;
                    else Ts.x = Tv.x * ( 0.5 + sign( R.Vec.x ) * ( 0.5 - Gd.x ) );

    if ( isinf( Tv.y ) ) Ts.y = FLOAT_MAX;
                    else Ts.y = Tv.y * ( 0.5 + sign( R.Vec.y ) * ( 0.5 - Gd.y ) );

    if ( isinf( Tv.z ) ) Ts.z = FLOAT_MAX;
                    else Ts.z = Tv.z * ( 0.5 + sign( R.Vec.z ) * ( 0.5 - Gd.z ) );

    float Td = Min( Ts.x, Ts.y, Ts.z ) / _DivN;

    float T0 = -0.5 * Td;
    float T1 = +1.5 * Td;

    [loop]
    for ( uint I = 0; I < _DivN; I++ )
    {
        float  T;
        float3 P;

        if ( HitFunc( R, T0, T1, T, P ) && ( T > 0 ) )
        {
            Result.Col.rgb = ( ( normalize( MathGrad( P ) ) + 1 ) / 2 );
            Result.Col.a   = 1;

            break;
        }

        T0 += Td;
        T1 += Td;
    }

    //·································

    Result.Col = _Opacity * Result.Col;

    return Result;
}

//############################################################################## ■
