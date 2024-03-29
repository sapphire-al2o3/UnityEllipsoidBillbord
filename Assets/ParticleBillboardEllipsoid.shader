
Shader "Custom/Particles/Ellipsoid"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_Width ("Width", Float) = 1.0
		_Length ("Length", Float) = 2.0

		[Enum(Default, 4, Always, 8)] _ZTest ("ZTest", Int) = 4
		[KeywordEnum(Off, On)] _ZWrite("Z Write", Int) = 0
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Src Blend Mode", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Dst Blend Mode", Float) = 10
		[KeywordEnum(None, Front, Back)] _Cull ("Culling", Int) = 0
	}
 
	SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		Blend [_SrcBlend] [_DstBlend]
		ZTest [_ZTest]
		Cull [_Cull]
		ZWrite [_ZWrite]
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;

			struct appdata_t {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				fixed4 color : COLOR;
				float4 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			fixed4 _Color;
			//float4 _MainTex_ST;
			float _Width;
			float _Length;

			v2f vert (appdata_t v)
			{
				v2f o;

				float4 pos = float4(0, v.texcoord.zw, 0);
				float3 view = ObjSpaceViewDir(pos);
				float width = _Width;
				float3 forward = float3(0, 0, 1);
				float3 side = normalize(cross(view, forward) + float3(0.001, 0, 0));
				float3 vert = normalize(cross(view, side));
				float3 tv = v.normal.x * width * side;
				tv += v.normal.y * width * vert;
				float len = _Length - width;
				tv -= pos.xyz * len;

				o.vertex = UnityObjectToClipPos(tv);
				o.color = _Color * v.color;
				o.texcoord = v.texcoord.xy;

				return o;
			}

			fixed4 frag (v2f i) : COLOR
			{
				fixed4 col = i.color;

				float2 s = (i.texcoord - 0.5) * 2.0;
				float dist2 = s.x * s.x + s.y * s.y;
				col.a = max((1.0 - dist2) * 0.5, 0.0);

				return col;
			}
			ENDCG 
		}
	}
	FallBack off
}
