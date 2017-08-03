// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/Simple"
{
	Properties
	{
		_MaskClipValue( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
		_BaseColor("Base Color", Color) = (1,1,1,1)
		_AlbedoMap("Albedo Map", 2D) = "white" {}
		_AlphaCutoff("Alpha Cutoff", Range( 0 , 1)) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+2" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_AlbedoMap;
		};

		uniform float4 _BaseColor;
		uniform sampler2D _AlbedoMap;
		uniform float _AlphaCutoff;
		uniform float _MaskClipValue = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 tex2DNode1 = tex2D( _AlbedoMap,i.uv_AlbedoMap);
			o.Albedo = ( _BaseColor * tex2DNode1 ).xyz;
			o.Alpha = 1;
			clip( ( ( tex2DNode1.a + _AlphaCutoff ) * _AlphaCutoff ) - _MaskClipValue );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
588;29;1135;916;1240.7;630.6998;1.3;True;True
Node;AmplifyShaderEditor.CommentaryNode;8;-910.9001,64.5001;Float;657;355;Alpha Cutoff Settings;3;6;5;7
Node;AmplifyShaderEditor.CommentaryNode;2;-908.0003,-538.0999;Float;543;484;Albedo Settings;3;4;3;1
Node;AmplifyShaderEditor.ColorNode;4;-827.0001,-495.0998;Float;Property;_BaseColor;Base Color;0;1,1,1,1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-552.0002,-367.0999;Float;COLOR;0.0,0,0,0;FLOAT4;0.0,0,0,0
Node;AmplifyShaderEditor.SamplerNode;1;-856.0001,-273.1;Float;Property;_AlbedoMap;Albedo Map;1;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;7;-875.9001,194.5;Float;Property;_AlphaCutoff;Alpha Cutoff;2;0;0;1
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-523.9001,121.5;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-380.9,243.5002;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;298,1;Float;True;2;Float;ASEMaterialInspector;Standard;PolyPixel/Simple;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Masked;0.5;True;True;2;False;TransparentCutout;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0.0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
WireConnection;3;0;4;0
WireConnection;3;1;1;0
WireConnection;5;0;1;4
WireConnection;5;1;7;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;0;0;3;0
WireConnection;0;9;6;0
ASEEND*/
//CHKSM=E5840F74A19190FCEF5C7778F5A939E647F54175