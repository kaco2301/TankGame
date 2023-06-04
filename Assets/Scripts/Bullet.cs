using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class Bullet : MonoBehaviour
{
    float speed = 30f;
    
    void Start()
    {
        Destroy(gameObject, 2f);
    }


    void Update()
    {
        float amount = speed * Time.deltaTime;
        transform.Translate(Vector3.forward * amount);

    }

    private void OnCollisionEnter(Collision collision)
    {
        Debug.Log("OnCollisionEnter() is occurred . . . ");
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Target")
        {
            //점수+10
            //타겟제거파티클
            //타겟제거사운드
            //타겟제거
            //Destroy(other.gameObject);
            if (other.tag == "Enemy")
            {
                other.transform.root.SendMessage("DestroySelf", transform.position);
            }
            Destroy(gameObject);
            //other.GetComponent<TargetDestroy>().DestroySelf(transform.position);

        }
        //총알제거
        Destroy(gameObject);
        
    }
}

