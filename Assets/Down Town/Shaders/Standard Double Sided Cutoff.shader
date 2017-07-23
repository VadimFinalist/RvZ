// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/StandardDoubleSided"
{
	Properties
	{
		_MaskClipValue( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
		_TintColor("Tint Color", Color) = (1,1,1,0)
		_AlbertoMap("Alberto Map", 2D) = "white" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		_MetalicMap("Metalic Map", 2D) = "white" {}
		_Metalic("Metalic", Range( 0 , 1)) = 1
		_Roughtness("Roughtness", Range( 0 , 1)) = 1
		_AmbientOcclusion("Ambient Occlusion", Range( 0 , 1)) = 1
		_AlphaCutoff("Alpha Cutoff", Range( 0 , 1)) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
		Cull Off
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_NormalMap;
			float2 uv_AlbertoMap;
			float2 uv_MetalicMap;
		};

		uniform float _NormalScale;
		uniform sampler2D _NormalMap;
		uniform float4 _TintColor;
		uniform sampler2D _AlbertoMap;
		uniform sampler2D _MetalicMap;
		uniform float _Metalic;
		uniform float _Roughtness;
		uniform float _AmbientOcclusion;
		uniform float _AlphaCutoff;
		uniform float _MaskClipValue = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = UnpackScaleNormal( tex2D( _NormalMap,i.uv_NormalMap) ,_NormalScale );
			float4 tex2DNode2 = tex2D( _AlbertoMap,i.uv_AlbertoMap);
			o.Albedo = ( _TintColor * tex2DNode2 ).xyz;
			float4 tex2DNode10 = tex2D( _MetalicMap,i.uv_MetalicMap);
			o.Metallic = ( tex2DNode10.r * _Metalic );
			o.Smoothness = ( tex2DNode10.g * _Roughtness );
			o.Occlusion = ( tex2DNode10.b * _AmbientOcclusion );
			o.Alpha = 1;
			clip( ( ( tex2DNode2.a + _AlphaCutoff ) * _AlphaCutoff ) - _MaskClipValue );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
790;29;969;918;1374.9;674.1;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;29;-818.9,269.9;Float;676;536;Metalic, Smoothness and AO Setup;7;10;13;12;11;14;15;16
Node;AmplifyShaderEditor.CommentaryNode;28;-1000.9,-10.09998;Float;603;254;Normal Settings;2;7;5
Node;AmplifyShaderEditor.CommentaryNode;27;-991.9,-296.1;Float;598;280;Alpha Cutoff;3;23;24;25
Node;AmplifyShaderEditor.CommentaryNode;26;-1237.9,-833.1;Float;528;527;Alberto Settings;3;19;2;17
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;True;2;Float;ASEMaterialInspector;Standard;PolyPixel/StandardDoubleSided;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;0;False;0;0;Masked;0.5;True;True;0;False;TransparentCutout;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0.0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-316,682;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-313,514;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-315,387;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;11;-741,507;Float;Property;_Metalic;Metalic;5;1;0;1
Node;AmplifyShaderEditor.RangedFloatNode;13;-744,694;Float;Property;_AmbientOcclusion;Ambient Occlusion;7;1;0;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-520.9,-118.1;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.ColorNode;17;-1165.9,-752.1;Float;Property;_TintColor;Tint Color;0;1,1,1,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-865.9,-606.1;Float;COLOR;0,0,0,0;FLOAT4;0.0,0,0,0
Node;AmplifyShaderEditor.SamplerNode;2;-1182,-512;Float;Property;_AlbertoMap;Alberto Map;1;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-619.9,-253.1;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;23;-967.9,-153.1;Float;Property;_AlphaCutoff;Alpha Cutoff;8;0;0;1
Node;AmplifyShaderEditor.SamplerNode;5;-751,36;Float;Property;_NormalMap;Normal Map;2;None;True;0;True;bump;Auto;True;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;7;-988,131;Float;Property;_NormalScale;Normal Scale;3;1;0;0
Node;AmplifyShaderEditor.SamplerNode;10;-729,319;Float;Property;_MetalicMap;Metalic Map;4;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;12;-741,594;Float;Property;_Roughtness;Roughtness;6;1;0;1
WireConnection;0;0;19;0
WireConnection;0;1;5;0
WireConnection;0;3;14;0
WireConnection;0;4;15;0
WireConnection;0;5;16;0
WireConnection;0;9;25;0
WireConnection;16;0;10;3
WireConnection;16;1;13;0
WireConnection;15;0;10;2
WireConnection;15;1;12;0
WireConnection;14;0;10;1
WireConnection;14;1;11;0
WireConnection;25;0;24;0
WireConnection;25;1;23;0
WireConnection;19;0;17;0
WireConnection;19;1;2;0
WireConnection;24;0;2;4
WireConnection;24;1;23;0
WireConnection;5;5;7;0
ASEEND*/
//CHKSM=883A07C414B6CC0D2C0F05CA634C543DC3F1A686