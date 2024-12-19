Shader "_Shaders/Unlit1.4"
{
    Properties
    {
        // PROPERTIES
        _Value ("Value", Float) = 1
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        Pass
        {
            CGPROGRAM
            #include "UnityCG.cginc"
            #include "Packages/com.timurproko.mytools/Assets/Shaders/MyTools.cginc"
            #pragma vertex vert
            #pragma fragment frag

            // VARIABLES
            float _Value;

            struct Attributes
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 uv : TEXCOORD0;
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
            };

            // VERTEX SHADER
            Interpolators vert(Attributes v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.uv = v.uv;
                return o;
            }

            // FRAGMENT SHADER
            float4 frag(Interpolators i) : SV_Target
            {
                float time = _Time.y * _Value ; 
                float xOffset = cos(i.uv.y * TAU * 8) * 0.01;
                float t = cos((i.uv.x + xOffset + time) * TAU * 8) * 0.5 + 0.5;
                return t;
            }
            ENDCG
        }
    }
}