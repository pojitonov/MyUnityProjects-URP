﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Sirenix/Editor/GUIIcon"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Blend SrcAlpha Zero
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment Fragment
            #include "UnityCG.cginc"

            struct Attributes {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Interpolators {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _Color;

            Interpolators vert(Attributes v) {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 Fragment(Interpolators i) : SV_Target {
                // drop shadow:
                // float texelSize = 1.0 / 34.0;
                // float2 shadowUv = clamp(i.uv + float2(-texelSize, texelSize * 2), float2(0, 0), float2(1, 1));
                // fixed4 shadow = fixed4(0, 0, 0, tex2D(_MainTex, shadowUv).a); 

                fixed4 col = _Color;
                col.a *= tex2D(_MainTex, i.uv).a;

                // drop shadow:
                // col = lerp(shadow, col, col.a);

                return col;
            }
            ENDCG
        }
    }
}