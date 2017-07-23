// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/EmissiveLightShader"
{
	Properties
	{
		_MaskClipValue( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
		_BaseMap("Base Map", 2D) = "white" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_LightColor("Light Color", Color) = (0.7519464,0.8430169,0.8970588,1)
		_EmissiveStrenght("Emissive Strenght", Float) = 7
		_AlphaCutoff("Alpha Cutoff", Range( 0 , 1)) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+2" }
		Cull Off
		CGPROGRAM
		#pragma target 4.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_NormalMap;
			float2 uv_BaseMap;
		};

		uniform sampler2D _NormalMap;
		uniform sampler2D _BaseMap;
		uniform float4 _LightColor;
		uniform float _EmissiveStrenght;
		uniform float _AlphaCutoff;
		uniform float _MaskClipValue = 0.5;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue, 0, 0, 0,0,contrastValue, 0, 0,0,0,contrastValue, 0,t, t, t, 1 ), colorTarget );
		}


		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			o.Normal = UnpackNormal( tex2D( _NormalMap,i.uv_NormalMap) );
			float4 tex2DNode10 = tex2D( _BaseMap,i.uv_BaseMap);
			o.Albedo = tex2DNode10.xyz;
			float4 temp_cast_1 = 0.33;
			o.Emission = lerp( float4( 0,0,0,0 ) , ( _LightColor * _EmissiveStrenght ) , CalculateContrast(tex2DNode10.g,temp_cast_1).r ).rgb;
			float3 temp_cast_4 = 0.65;
			o.Specular = temp_cast_4;
			o.Smoothness = 0.5;
			o.Alpha = 1;
			clip( ( ( tex2DNode10.a + _AlphaCutoff ) * _AlphaCutoff ) - _MaskClipValue );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
193;29;1135;916;1349.478;381.4713;1.3;True;True
Node;AmplifyShaderEditor.CommentaryNode;25;-1463.721,-112.1412;Float;343.1779;327.1794;Albedo Setup;1;10
Node;AmplifyShaderEditor.CommentaryNode;24;-1534.808,322.9896;Float;691.7908;434.6832;Opacity Setup;3;20;19;21
Node;AmplifyShaderEditor.CommentaryNode;23;-763.5583,130.6217;Float;379.8098;255.4499;Normal Setup;1;11
Node;AmplifyShaderEditor.CommentaryNode;22;-1015.369,-655.1571;Float;716.4142;596.0266;Emissive Setup;6;14;15;13;1;12;28
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;True;4;Float;ASEMaterialInspector;StandardSpecular;PolyPixel/EmissiveLightShader;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;0;False;0;0;Masked;0.5;True;True;2;False;TransparentCutout;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.SamplerNode;11;-696.3001,196.2;Float;Property;_NormalMap;Normal Map;1;None;True;0;True;bump;Auto;True;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;15;-928.7729,-323.5844;Float;Property;_EmissiveStrenght;Emissive Strenght;2;7;0;0
Node;AmplifyShaderEditor.ColorNode;14;-956.4852,-582.4789;Float;Property;_LightColor;Light Color;2;0.7519464,0.8430169,0.8970588,1
Node;AmplifyShaderEditor.RangedFloatNode;21;-1515.169,530.994;Float;Property;_AlphaCutoff;Alpha Cutoff;4;0;0;1
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1138.573,389.6623;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-967.1344,536.8023;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.SamplerNode;10;-1427.545,-27.72768;Float;Property;_BaseMap;Base Map;0;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;18;-301.9002,284.9002;Float;Constant;_Smoothness;Smoothness;4;0.5;0;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-304.0002,192.5002;Float;Constant;_Specular;Specular;4;0.65;0;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-917.4122,-182.8606;Float;Constant;_Float0;Float 0;2;0.33;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-633.278,-378.7713;Float;COLOR;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleContrastOpNode;1;-676.8824,-171.4538;Float;0.34;FLOAT;0.0;COLOR;0,0,0,0
Node;AmplifyShaderEditor.LerpOp;13;-470.3455,-290.4393;Float;COLOR;0,0,0,0;COLOR;0,0,0,0;COLOR;0.0,0,0,0
WireConnection;0;0;10;0
WireConnection;0;1;11;0
WireConnection;0;2;13;0
WireConnection;0;3;17;0
WireConnection;0;4;18;0
WireConnection;0;9;20;0
WireConnection;19;0;10;4
WireConnection;19;1;21;0
WireConnection;20;0;19;0
WireConnection;20;1;21;0
WireConnection;28;0;14;0
WireConnection;28;1;15;0
WireConnection;1;0;10;2
WireConnection;1;1;12;0
WireConnection;13;1;28;0
WireConnection;13;2;1;0
ASEEND*/
//CHKSM=D1C4E10A9D74773B9784D81ECAF6E9986CC93BB5