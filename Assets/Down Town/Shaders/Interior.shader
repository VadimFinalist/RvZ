// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/Interior"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Background"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 vertexColor : COLOR;
		};

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 temp_cast_0 = ( 0.5 * i.vertexColor.r );
			o.Albedo = temp_cast_0;
			float temp_output_5_0 = 0.0;
			float3 temp_cast_1 = temp_output_5_0;
			o.Emission = temp_cast_1;
			o.Metallic = temp_output_5_0;
			o.Smoothness = temp_output_5_0;
			float temp_output_3_1 = i.vertexColor.r;
			o.Occlusion = temp_output_3_1;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
-1029;173;1906;1004;997;349;1;True;True
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-192,80;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.VertexColorNode;3;-502,212;Float
Node;AmplifyShaderEditor.RangedFloatNode;2;-496,-8;Float;Constant;_Float0;Float 0;0;0.5;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;90,80;Float;True;2;Float;ASEMaterialInspector;Standard;PolyPixel/Interior;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;True;Background;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.RangedFloatNode;5;-188,172;Float;Constant;_Float1;Float 1;0;0;0;0
WireConnection;4;0;2;0
WireConnection;4;1;3;1
WireConnection;0;0;4;0
WireConnection;0;2;5;0
WireConnection;0;3;5;0
WireConnection;0;4;5;0
WireConnection;0;5;3;1
ASEEND*/
//CHKSM=F238C3D4F1E11D1F150BBAD8E75F1D1B99CCD267