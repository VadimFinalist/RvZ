using UnityEngine;
using System.Collections;
using System.Collections.Generic;
public class WeaponController : MonoBehaviour 
{
	[System.Serializable]
	public class HitEffectComponent
	{
		public PhysicMaterial m_PhysicMaterial;
		public GameObject m_HitEffect;
	}

	public  List<HitEffectComponent> m_Effects;

	// Update is called once per frame
	void Update () 
	{
		if(Input.GetMouseButtonDown(0))
		{
			DoTrace(Camera.main.transform);
		}
	}

	void DoTrace(Transform fireFrom)
	{
		Vector3 direction = fireFrom.forward;

		Ray ray = new Ray(fireFrom.position, direction);

		RaycastHit hit;

		if (!Physics.Raycast (ray, out hit,1000f,~(1<<LayerMask.NameToLayer("Char"))))
			return;

		//SpawnHitDecal(hit.point,hit.normal,hit.collider.gameObject);

        if (WPN_Decal_Manager.Instance != null )
        {
            WPN_Decal_Manager.Instance.SpawnBulletHitEffects(hit.point, hit.normal, hit.collider.material, hit.collider.gameObject);
        }
	}
		
	void SpawnHitDecal(Vector3 _hit,Vector3 _normal,GameObject _HittedObject)
	{
		Debug.DrawLine (_hit, _normal * 100f,Color.blue,10);
		PhysicMaterial mat = _HittedObject.GetComponent<Collider>().sharedMaterial;

		HitEffectComponent effectToSpawn = m_Effects.Find(w=>w.m_PhysicMaterial.name == mat.name);

		if(effectToSpawn == null)
			return;
			
		GameObject dec =  Instantiate(effectToSpawn.m_HitEffect, 
			_hit, 
			Quaternion.FromToRotation(Vector3.forward,_normal)) as GameObject;

		dec.GetComponent<HitEffect> ().m_Rot = _normal;

	}

}
