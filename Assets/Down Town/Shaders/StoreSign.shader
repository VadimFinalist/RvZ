// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/StoreSign"
{
	Properties
	{
		_MaskClipValue( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
		_BaseColor("Base Color", Color) = (1,1,1,1)
		_AlbedoMap("Albedo Map", 2D) = "white" {}
		_AlphaCutoff("Alpha Cutoff", Range( 0 , 1)) = 0
		_StoreDecals("Store Decals", 2D) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+1" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha  
		struct Input
		{
			float2 uv_AlbedoMap;
			float2 uv_StoreDecals;
		};

		uniform float4 _BaseColor;
		uniform sampler2D _AlbedoMap;
		uniform sampler2D _StoreDecals;
		uniform float _AlphaCutoff;
		uniform float _MaskClipValue = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 tex2DNode1 = tex2D( _AlbedoMap,i.uv_AlbedoMap);
			o.Albedo = lerp( _BaseColor , tex2DNode1 , tex2DNode1.a ).xyz;
			o.Alpha = 1;
			float4 tex2DNode9 = tex2D( _StoreDecals,i.uv_StoreDecals);
			clip( ( ( tex2DNode9.r + _AlphaCutoff ) * _AlphaCutoff ) - _MaskClipValue );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
627;30;969;916;592.3;194.9001;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;8;-873.1999,242.7001;Float;657;355;Alpha Cutoff Settings;4;6;5;7;9
Node;AmplifyShaderEditor.CommentaryNode;2;-786,-303;Float;543;484;Albedo Settings;3;4;1;10
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;True;2;Float;ASEMaterialInspector;Standard;PolyPixel/StoreSign;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Masked;0.5;True;False;1;False;TransparentCutout;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0.0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-486.2,299.7;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-343.2,421.7;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;7;-830.2,487.8996;Float;Property;_AlphaCutoff;Alpha Cutoff;2;0;0;1
Node;AmplifyShaderEditor.SamplerNode;9;-835.2999,288.0999;Float;Property;_StoreDecals;Store Decals;3;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SamplerNode;1;-761,-26;Float;Property;_AlbedoMap;Albedo Map;1;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.ColorNode;4;-748,-262;Float;Property;_BaseColor;Base Color;0;1,1,1,1
Node;AmplifyShaderEditor.LerpOp;10;-437.3,-101.9001;Float;COLOR;0,0,0,0;FLOAT4;0.0,0,0,0;FLOAT;0.0
WireConnection;0;0;10;0
WireConnection;0;9;6;0
WireConnection;5;0;9;1
WireConnection;5;1;7;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;10;0;4;0
WireConnection;10;1;1;0
WireConnection;10;2;1;4
ASEEND*/
//CHKSM=E98DF85F4ACF0EFAB459733DB44FED5E7A360444