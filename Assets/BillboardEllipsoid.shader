
Shader "Custom/Particles/Ellipsoid"
{
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
		_Width ("Width", Float) = 1.0
		_Length ("Length", Float) = 2.0

		[Enum(Default, 4, Always, 8)] _ZTest ("ZTest", Int) = 4
		[KeywordEnum(Off, On)] _ZWrite("Z Write", Int) = 0
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Src Blend Mode", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Dst Blend Mode", Float) = 10
		[KeywordEnum(None, Front, Back)] _Cull ("Culling", Int) = 0
	}
 
	SubShader {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend [_SrcBlend] [_DstBlend]
		ColorMask RGB
		ZTest [_ZTest]
		Cull [_Cull]
		ZWrite [_ZWrite]
		Lighting Off Fog { Mode Off }
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma multi_compile_particles

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;

			struct appdata_t {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			fixed4 _Color;
			float4 _MainTex_ST;
			float _Width;
			float _Length;

			v2f vert (appdata_t v)
			{
				v2f o;

				float3 view = ObjSpaceViewDir(v.vertex);
				float width = _Width;
				float3 forward = float3(0, 0, 1);
				float3 side = normalize(cross(view, forward) + float3(0.001, 0, 0));
				float3 vert = normalize(cross(view, side));
				float3 tv = v.normal.x * width * side;
				tv += v.normal.y * width * vert;
				float len = _Length - width;
				tv -= v.vertex.xyz * len;

				o.vertex = UnityObjectToClipPos(tv);
				o.color = _Color;
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);

				return o;
			}

			fixed4 frag (v2f i) : COLOR
			{
				fixed4 col = tex2D(_MainTex, i.texcoord.xy);

				float2 s = (i.texcoord - 0.5) * 2.0;
				float dist2 = s.x * s.x + s.y * s.y;
				col.a = (1.0 - dist2) * 0.5;

				return col * i.color;

			}
			ENDCG 
		}
	}
	FallBack off
}
